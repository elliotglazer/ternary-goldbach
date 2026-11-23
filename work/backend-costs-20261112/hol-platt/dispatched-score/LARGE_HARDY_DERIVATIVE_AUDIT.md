# Derivative bound for the large-family Hardy amplitude

Let \(\chi\) be primitive and nonprincipal, of conductor \(q\), parity \(a\in\{0,1\}\), and root number \(\epsilon_\chi\). Use \(\Lambda_\chi(s)=(q/\pi)^{(s+a)/2}\Gamma((s+a)/2)L(s,\chi)\). Fix \(|\eta|=1\) with \(\eta^2\epsilon_\chi=1\). Define
\[
F(s)=\eta e^{-i\pi(s-1/2)/4}\Lambda_\chi(s),\qquad A(t)=F(1/2+it).
\]
The functional equation and conjugation give \(\Lambda_\chi(1/2+it)=\epsilon_\chi\overline{\Lambda_\chi(1/2+it)}\). Thus \(A(t)\) is real, including for a complex character. Either square-root sign works for the bound. A sign certificate must use the phase chosen by its data. [Primitive functional equation](https://dlmf.nist.gov/25.15.E5)

Fix an integer \(b\ge2\), \(B=b-1/2\), \(0<\rho\le B\), \(p=(b+a-1)/2\), \(D=b+2+|t|\), and \(C=\sqrt{B^2+\rho^2}\). On the closed disc centered at \(1/2+it\) of radius \(\rho\),
\[
|F(s)|\le M(t)=2\sqrt{2\pi}\,(q/\pi)^{(b+a)/2}\,D^p e^{pC/D}.
\]

**Gamma bound on the vertical boundary.** Set \(v=|y|/2\), \(J=b+2+|y|\), \(x=(b+a)/2\). At the half-integer base, \(e^{\pi v}|\Gamma(1/2+iv)|^2\le2\pi\). At the integer base the same expression for \(\Gamma(1+iv)\) equals \(2\pi v/(1-e^{-2\pi v})\le 2\pi(v+1/(2\pi))\le2\pi J\). The inequality follows from \(e^z\ge1+z\); take the limit at \(v=0\). Each remaining recurrence factor has modulus at most \(J\). Counting these factors gives \(e^{\pi y/4}|\Gamma(x+iy/2)|\le\sqrt{2\pi}J^{x-1/2}\). [Gamma modulus identities](https://dlmf.nist.gov/5.4.i) · [Recurrence](https://dlmf.nist.gov/5.5.E1)

**Strip bound.** On \(\Re s=b\), absolute convergence gives \(|L(s,\chi)|\le\zeta(b)\le 1+\int_1^\infty x^{-b}dx\le2\). The functional equation takes \(1-b+iy\) to \(b-iy\) for the conjugate character. The gamma modulus is even in \(y\), so the same bound applies with the external factor \(e^{\pi y/4}\). Write \(u=y-t\). For \(G(s)=F(s)e^{\delta(s-1/2-it)^2}\) with \(\delta>0\), the vertical boundary estimate after removing the constant \(2\sqrt{2\pi}(q/\pi)^x\) is
\[
e^{\delta B^2}(D+|u|)^p e^{-\delta u^2}
\le D^p \exp\!\left(\delta B^2+\frac{p^2}{4\delta D^2}\right).
\]
Here \(\log(1+|u|/D)\le |u|/D\), followed by completing the square. The horizontal edges tend uniformly to zero by order at most one of the entire completion. Equivalently its split theta Mellin integral gives a finite uniform bound for \(\Lambda_\chi\) on this fixed strip: imaginary powers have modulus one, and both tails on \([1,\infty)\) decay exponentially. Either analytic input suffices for the maximum principle on finite rectangles. On the disc the inverse Gaussian contributes at most \(e^{\delta\rho^2}\). Choosing \(\delta=p/(2DC)\) yields \(M(t)\).

**Interpolation.** Cauchy's estimate gives \(|A^{(m)}(t)|\le m!M(t)/\rho^m\). For \(m\) distinct real interpolation nodes \(t_j\), the usual real Lagrange error is bounded by \(\max_{\xi\in I}M(\xi)\prod_j|x-t_j|/\rho^m\), with \(I\) the convex hull of all nodes and the evaluation point. If a sample has a certified error, add its error multiplied by the absolute value of its Lagrange weight. The factorial cancels exactly. For a common \(b,\rho\), maximize \(D^p e^{pC/D}\) over both endpoints of the range of \(D\), including the value \(D=b+2\) if \(I\) crosses zero. The derivative of its logarithm is \(p(D-C)/D^2\). Its only interior critical point is a minimum. A formula using the larger \(D\) alone needs a separate monotonicity check. This argument is a mathematical audit; proof transport of the analytic inputs remains open.
