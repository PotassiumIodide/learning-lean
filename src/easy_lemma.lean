import data.real.basic

-- ℕ = {0,1,2,...}

example (n : ℕ) : (1 : ℝ) ≤ 1.5^n :=
begin
  have h : (1 : ℝ) ≤ 1.5 := by norm_num,
  exact one_le_pow_of_one_le h n,
end
/-
simp -- A = B または A ↔ Bの形を解く
norm_num -- 数値を用いた1.5 < 1.7のような形を解く
linarith -- 線形不等式を解く
library_search -- 必要となりそうな補題を探す(1 ≤ x → 1 ≤ x^nの形なら使える)
-/

example (n : ℕ) : (1 : ℝ) ≤ 1.5^n :=
begin
  apply one_le_pow_of_one_le,
  norm_num,
end