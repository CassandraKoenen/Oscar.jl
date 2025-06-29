```@meta
CurrentModule = Oscar
```

# Introduction
This project was developed as part of [Koe25](@cite) and provides functionality for
constructing and calculating in Drinfeld--Hecke algebras
as introduced by Ram and Shepler [RS03](@cite), but for matrix 
groups over general fields.

## Mathematical background

Let $K$ be a field, $R$ a $K$-algebra and $G$ a finite matrix group over $K$
acting on a $K$-vector space $V$ linearly. This setting is slightly
more general than the one by Ram and Shepler [RS03](@cite), but Thiel [Thi14](@cite)[16.69]
has shown that the PBW Theorem also holds when working with modules
over arbitrary rings.

To avoid confusion with the multiplication of the skew group algebra,
we will write the group action of an element $g\in G$ on $v\in V$ as $^gv$.

Recall that for an $R$-algebra $A$ acting on a group $G$ via $R$-automorphisms,
the skew group algebra $A\#G$ is defined as the left $A$-module generated
by the elements of $G$ with multiplication $(ag)(bh) = (a ^gb)(gh)$ for $a,b\in A$,
$g,h\in G$.


A Drinfeld--Hecke form is a sum
$\kappa := \sum_{g\in G} \kappa_g \cdot g$
of alternating bilinear forms $\kappa_g\colon V\times V \rightarrow R$
such that the relations posed in [RS03](@cite)[Lemma 1.5] are satisfied:

- $\kappa_g(u,v)(^gw-w)+\kappa_g(v,w)(^gu-u)+\kappa_g(w,u)(^gv-v) = 0$ for all $u,v,w\in V$ and $g\in G$
- $\kappa_g(^hv,^hw)=\kappa_{h^{-1}gh}(v,w)$ for all $v,w\in V$ and $g, h\in G$

A Drinfeld--Hecke algebra is the algebra
$H_{\kappa}(G) := R\langle V \rangle \# G / I_{\kappa}$
where $R\langle V \rangle$ is the ring of noncommutative $R$-polynomial functions on $V$ and
$I_{\kappa} := \langle vw-wv-\kappa(v,w) \;|\; v,w\in V\rangle$
with $\kappa$ a Drinfeld--Hecke form.

This project further provides methods for generating generic (i.e. parametrized) 
Drinfeld--Hecke algebras using two strategies depending on the setup:
- If $\text{char}(K) \neq 0$, the generic algebra is constructed directly from the relations above
- If $\text{char}(K) = 0$, a generalized version of [RS03](@cite)[Theorem 1.9] is used to find generic algebras in a more efficient way. A proof for the generalized version was done in [Koe25](@cite).

Fixing a basis $(v_1,\dots,v_n)$ for $V$ allows us to think of $R\langle V\rangle$ as the non-commutative polynomial
ring over this basis. Using the numbering $1,\dots,n$ as an order,
 we can uniquely represent any element in the Drinfeld--Hecke algebra as a sum $\sum_{g\in G}f_g g$ where 
$f_g \in R\langle V\rangle$ with all indeterminants in correct order.

For a detailed overview of the theorey please refer to [Koe25](@cite).

## Example

Let us consider the cyclic group of order $2$ acting on $\mathbb{Q}^2$
via the matrix group $G$ generated by $\text{diag}(-1)$.

```jldoctest
julia> G = matrix_group(matrix(QQ, [-1 0;0 -1]))
Matrix group of degree 2
  over rational field

# Next we calculate the generic Drinfeld--Hecke form for G

julia> A = generic_drinfeld_hecke_algebra(G)
Drinfeld-Hecke algebra
   for Matrix group of degree 2 over QQ
with generators
   x1, x2, g1

defined by Drinfeld-Hecke form over base ring
   Multivariate polynomial ring in 2 variables over QQ
with parameters 
   t1, t2
given by alternating bilinear forms
   [1   0] => [  0   t1]
   [0   1]    [-t1    0]

   [-1    0] => [  0   t2]
   [ 0   -1]    [-t2    0]

# As we can see there are three generators listed here. 
# The generators x1 and x2 are the indeterminants of the
# underlying algebra R⟨V⟩ whereas g1 is the generator
# of the group. Generators and parameters can be easily 
# accessed:

julia> A[3]
[-1    0]
[ 0   -1]

julia> A[1]
x1

julia> params(A)
2-element Vector{QQMPolyRingElem}:
 t1
 t2

# If one wants to switch to a concrete setting without parameters,
# the method "evaluate_parameters" can be used:

julia> evaluate_parameters(A, [2,3//4])
Drinfeld-Hecke algebra
   for Matrix group of degree 2 over QQ
with generators
   x1, x2, g1

defined by Drinfeld-Hecke form over base ring
   Multivariate polynomial ring in 2 variables over QQ
with parameters 
   t1, t2
given by alternating bilinear forms
   [1   0] => [ 0   2]
   [0   1]    [-2   0]

   [-1    0] => [    0   3//4]
   [ 0   -1]    [-3//4      0]

# The values in the given array can be anything that 
# can be coerced into an element of the base ring of A, 
# for example it could also be a parameter shift:

julia> (t_1,t_2) = parameters(A)
2-element Vector{QQMPolyRingElem}:
 t1
 t2

julia> evaluate_parameters(A, [-t_1,-t_2/2])
Drinfeld-Hecke algebra
   for Matrix group of degree 2 over QQ
with generators
   x1, x2, g1

defined by Drinfeld-Hecke form over base ring
   Multivariate polynomial ring in 2 variables over QQ
with parameters 
   t1, t2
given by alternating bilinear forms
   [1   0] => [ 0   -t1]
   [0   1]    [t1     0]

   [-1    0] => [      0   -1//2*t2]
   [ 0   -1]    [1//2*t2          0]

# There is additionally the option to directly define
# Drinfeld--Hecke algebras passing the alternating bilinear
# forms defining the associated Drinfeld-Hecke form

julia> R, (x,y) = polynomial_ring(QQ, ["x","y"])
(Multivariate polynomial ring in 2 variables over QQ, QQMPolyRingElem[x, y])

julia> κ_1 = matrix(R, [0 x; -x 0])
[ 0   x]
[-x   0]

julia> κ_g = matrix(R, [0 y; -y 0])
[ 0   y]
[-y   0]

julia> forms = Dict(one(G) => κ_1, G[1] => κ_g)
Dict{MatrixGroupElem{QQFieldElem, QQMatrix}, AbstractAlgebra.Generic.MatSpaceElem{QQMPolyRingElem}} with 2 entries:
  [1 0; 0 1]   => [0 x; -x 0]
  [-1 0; 0 -1] => [0 y; -y 0]

julia> B = drinfeld_hecke_algebra(forms)
Drinfeld-Hecke algebra
   for Matrix group of degree 2 over QQ
with generators
   x1, x2, g1

defined by Drinfeld-Hecke form over base ring
   Multivariate polynomial ring in 2 variables over QQ
with parameters 
   x, y
given by alternating bilinear forms
   [1   0] => [ 0   x]
   [0   1]    [-x   0]

   [-1    0] => [ 0   y]
   [ 0   -1]    [-y   0]

# Let us do some arithmetic. Since multiplication
# is not commutative in Drinfeld-Hecke algebras, one 
# must pay attention to this when defining elements.

julia> A[1]*A[2]
x1*x2

julia> A[2]*A[1]
x1*x2 - t1
 + 
-t2 * [-1    0]
      [ 0   -1]
      
julia> A[3]*A[1]
-x1 * [-1    0]
      [ 0   -1]

julia> R = base_algebra(A)
Multivariate polynomial ring in 2 variables x1, x2
  over multivariate polynomial ring in 2 variables over QQ

julia> (x,y) = gens(R)
2-element Vector{AbstractAlgebra.Generic.MPoly{QQMPolyRingElem}}:
 x1
 x2

julia> A(x*y)
x1*x2


julia> A(y*x)
x1*x2


julia> A(y)*A(x)
x1*x2 - t1
 + 
-t2 * [-1    0]
      [ 0   -1]
```
