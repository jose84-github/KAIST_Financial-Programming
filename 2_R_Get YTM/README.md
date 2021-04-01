## Financial-Programming  
1. Homework2
* Develop a function get_ytm(F,T,c,f,PV) which returns ytm(yield to maturity of a coupon bond.

	Where
	
	F = face value
	T = time to maturity
	C = coupon rate
	F = the number of coupon payments in a year
	PV = market price of a bond

	* Continuous componding interest rate 사용하기
	* YTM은 모르고 Market Price(PV)를 통해서 YTM을 역 도출하기
	* Root find problem -> finding variable X -> f(x)=0이 되는 x를 찾아내는 것 -> 즉, 방정식의 근을(해) 찾아내주는 함수
		* F(x) = ∑24_(i=1)^12(F_i,e^(−rt_i )−PV)=0
			* F (r, F, c, T, …PV) = 0인 f(x)의 r을 찾으면 됨
		* Uniroot함수를 활용하면 Iteration, root 변수를 통해서 여러가지 것들을 알 수 잇음
			* Uniroot (f, interval, lower, upper…) 파라메터
				* F : the function for which the root is sought
				* Interval : a vector containing the end-points of the interval to be searched for the root.
				* F.lower : the same as f(upper) and f(lower), respectively. 
				* F.upper : Passing these values from the caller where they are often known is more economical as soon as f() contains non-trivial computations.
				* Tol : the desired accuracy
			* 결과값
				* Root : 근
				* F.root : 근이 입력되었을 때 함수의 리턴값 (=y값)
				* Iter : 근을찾기 위해 Iteration한 횟수
				* etim.prec : 찾아낸 근의 정확도
			* Uniroot함수의 결과값을 Sol로 받아서 출력
				* Sol <- uniroot(f2, y=2, c(2,5))
					* 여기서 c(2,5)는 Interval을(근으로 입력할 범위) 나타냄

