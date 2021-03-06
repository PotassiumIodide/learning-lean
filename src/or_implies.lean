-- P, Q, Rを命題としたとき，以下が同値であることを示す:
-- (i)  P または Q ならば R
-- (ii) P ならば R かつ Q ならば R

-- structured proofによる証明
example (p q r : Prop) : ((p ∨ q) → r) ↔ ((p → r) ∧ (q → r)) :=
begin
	split, -- 十分性と必要性に分ける

	-- 十分性(i) => (ii)が成り立つことを示す．
	{ intro h, -- 「P または Q ならば R」が成り立つと仮定し，それを仮定hとおく．
		split, -- 「P ならば R かつ Q ならば R」を「P ならば R」と「Q ならば R」に分割する
		
		-- 「P ならば R」が成り立つことを示す．
		{	intro hp,  -- Pが成り立つと仮定し，これを仮定hpとおく
		  apply h,   -- 今，仮定h「P または Q ならば R」が成立している．
			left,      -- 「P または Q」の左側「P」が成り立つことを示す．
			assumption -- 仮定hpより「P」は真．
		}, 
		
		-- 「Q ならば R」が成り立つことを示す．
		{	intro hq,  -- Qが成り立つと仮定し，これを仮定hqとおく
		  apply h,   -- 今，仮定h「PまたはQならばR」が成立している．
			right,     -- 「P または Q」の右側「Q」が成り立つことを示す．
			assumption -- 仮定hqより「Q」は真．
		}
	},
	
	-- 必要性(ii) => (i)が成り立つことを示す．
	{ intro h, -- 「P ならば R かつ Q ならば R」が成り立つと仮定し，それを仮定hとおく．
	  cases h with hpr hqr, -- hを「PならばR」が成り立つという仮定hprと「QならばR」が成り立つという仮定hqrに分ける
		intro hpq, -- 「P または Q」 が成り立つと仮定し，これを仮定hpqとおく．
		cases hpq with hp hq, -- 仮定hpqを「Pが成り立つ」という仮定hpと「Qが成り立つ」という仮定hqに分ける．

		-- 仮定hp「Pが成り立つ」の下で「Rが成り立つ」ことを示す．
		{ apply hpr, -- 今、「PならばR」が成り立っている
		  assumption -- 仮定よりPが成り立っているので、示された．
		},
		-- 仮定hp「Qが成り立つ」の下で「Rが成り立つ」ことを示す．
		{ apply hqr, -- 今、「Q ならば R」が成り立っている
		  assumption -- 仮定よりQが成り立っているので，示された．
		}
	}
end

-- 函数定義による証明
-- 「P型かQ型の値を受け取ってR型の値を返す関数」を引数に取って
-- 「P型の値を受け取ってR型の値を返す関数」と「Q型の値を受け取ってR型の値を返す関数」のペアを返す関数
-- と
-- 「P型の値を受け取ってR型の値を返す関数」と「Q型の値を受け取ってR型の値を返す関数」のペアを返す関数を引数に取って
-- 「P型かQ型の値を受け取ってR型の値を返す関数」を返す関数
-- のペアが定義出来れば命題が示せたことになる．
example (p q r : Prop)  : ((p ∨ q) → r) ↔ ((p → r) ∧ (q → r)) :=
⟨ λ h, ⟨ λ hp, h $ or.inl hp, λ hq, h $ or.inr hq ⟩, λ ⟨ hpr, hqr ⟩ hpq, hpq.elim hpr hqr ⟩
-- 第一成分のλ式「λ h, ⟨ λ hp, h $ or.inl hp, λ hq, h $ or.inr hq ⟩」について
-- 引数hは「P型かQ型の値を受け取ってR型の値を返す関数」
-- 戻り値は「⟨ λ hp, h $ or.inl hp, λ hq, h $ or.inr hq ⟩」
-- (この第一成分が「P型の値を引数に取ってR型の値を返す関数」、
-- 第二成分が「Q型の値を引数に取ってR型の値を返す関数」となっていればよい)
--   第一成分のλ式「λ hp, h $ or.inl hp」について
--   引数hpは「P型の値」
--   or.inlは「任意の型Aを型Aまたは任意の型Bの値へ写す関数」
--   or.inl hpは「型Pの値hpを「型Pまたは任意の型B」の値と見る」
--   ただしhは「型Pまたは型Qの値」を引数に取るので、
--   型推論により「or.inl hp」は「型Pまたは型Qの値」となる．
--   関数hにより、型Pまたは型Qの値「or.inl hp」は「R型の値」へ写される
--   よって、第一成分は「P型の値を引数に取ってR型の値を返す関数」
--
--   第二成分のλ式「λ hq, h $ or.inr hq」について
--   引数hqは「Q型の値」
--   or.inrは「任意の型Bを型Aまたは任意の型Bの値へ写す関数」
--   or.inr hqは「型Qの値hqを「型Aまたは任意の型Q」の値と見る」
--   ただしhは「型Pまたは型Qの値」を引数に取るので、
--   型推論により「or.inr hq」は「型Pまたは型Qの値」となる．
--   関数hにより、型Pまたは型Qの値「or.inr hq」は「R型の値」へ写される
--   よって、第二成分は「Q型の値を引数に取ってR型の値を返す関数」
--    
-- 第二成分のλ式「λ ⟨ hpr, hqr ⟩ hpq, hpq.elim hpr hqr」について
-- 引数⟨ hpr, hqr ⟩は「P型の値を受け取ってR型の値を返す関数」hprと
-- 「Q型の値を受け取ってR型の値を返す関数」hqrとの対
-- 戻り値は「hpq, hpq.elim hpr hqr」
-- (この第一成分が「P型の値を引数に取ってR型の値を返す関数」、
-- 第二成分が「Q型の値を引数に取ってR型の値を返す関数」となっていればよい)