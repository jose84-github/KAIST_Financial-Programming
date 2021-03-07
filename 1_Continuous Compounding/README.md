## Financial-Programming
	1. Homework
	• Bond Price YTM을 계산하는 함수
		○ F: Face Value of Bond
		○ T: Time to Maturity of Bond
		○ c : Coupon Rate
		○ f : Number of Coupon Payment
		○ ytm : Interest Rate
	• Bond Price Zero Rate를 계산하는 함수
		○ F: Face Value of Bond
		○ T: Time to Maturity of Bond
		○ c : Coupon Rate
		○ f : Number of Coupon Payment
		○ ytm : Vector of Zero Rate
	• 두 함수를 작성하여 bond_price.R에 저장

	• Source('bond_price.R')로 함수를 콜
	• bond_price_ytm(100, 3, 0.04, 4, 0.01)로 함수 실행하여 108.8516이 결과로 나오도록
	• r <-seq (0.01, 0.03, 0.02/11)
	• bond_price_zero_rate(100, 3, 0.04, 4, r)로 함수 실행하여 102.9511이 결과로 나오도록
	

	• Bond Price under Continuous Compounding
	
![image](https://user-images.githubusercontent.com/74888819/110228111-e1a1a100-7f41-11eb-8182-cfbb155990ae.png)
