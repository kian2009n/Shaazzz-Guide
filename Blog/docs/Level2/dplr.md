--- 
hide:
  - footer
comments: true
---
# dp بازه ای

## توضیحات 
## دیپی l r

## توضیحات 

یکی از ایده های معروف دیپی، دیپی l r است. در بعضی از مدل سوال ها، ما باید یک $dp[l][r]$ را تعریف کنیم، که مسئله را روی یک بازه خاص بررسی میکند.

### مسئله Deque
یک آرایه $N$ عضوی داریم. آلیس و باب با این آرایه بازی میکنند. آلیس بازی را شروع میکند و هر کس در نوبت خود یکی از عضو های اول یا آخر آرایه را حذف میکند و اگر آن عضو $x$ بود، آن بازیکن $x$ امتیاز میگیرد. بازی ادامه تا وقتی که حداقل یک عضو از آرایه باقی بماند ادمه پیدا میکند.
اگر $X$ امتیاز آلیس و $Y$ امتیاز باب باشد، هدف آلیس بیشتر کردن $X-Y$ است و هدف باب کمتر کردن $X - Y$ است. در صورتی که بازیکن ها به بهترین نحو ممکن عمل کنند، $X-Y$ پس از تمام شدن بازی چه خواهد بود؟ 

??? success "راه حل"
	برای یک $1 \leq l \leq r \leq N$  مسئله را روی آرایه $a_l , a_{l+1} , \dots a_r$ بررسی میکنیم. $dp[l][r]$ برابر $X - Y$ است اگر مسئله را روی این آرایه حل کنیم.
	حال اولین حرکت را بررسی میکنیم: 
	اگر آلیس $a_l$ را حذف کند، مسئله در بازه $[l+1,r]$ حل میشود. اگر $dp[l+1][r]$ به صورت $X-Y$ باشد. $dp[l][r]$ برابر $a_l + Y - X$ خواهد بود، چون $X$ برابر امتیاز باب در $[l+1][r]$ است. (به دلیل این که در $dp[l+1][r]$ باب بازی را شروع میکند.) پس یکی از حالات $a_l - dp[l+1][r]$ است، و با منطق مشابه، حالت بعدی $a_r - dp[l][r-1]$ است.
	لذا نتیجه میگیریم که $dp[l][r] = max(a_l - dp[l+1][r], a_r - dp[l][r-1])$.
??? success "پیاده سازی"
	```cpp linenums="1"
	for(int i = 1; i <= N; i ++) {
		dp[i][i] = a[i];
	}
	for(int len = 2; len <= N; len ++) {
		for(int l = 1; l + len-1 <= N; l ++) {
			int r = l + len-1;
			dp[l][r] = max(a[l] - dp[l+1][r], a[r] - dp[l][r-1]);
		}
	}
	```

### مسئله LPS
یک رشته $n$ عضوی $s$ داریم و میخواهیم اندازه بزرگترین زیر دنباله پالیندروم آن را بدست بیاریم. 
??? success "راه حل"
	مسئله را برای در یک زیربازه از $s$ بررسی میکنیم. $dp[l][r]$ را برابر بزرگترین زیر دنباله پالیندروم زیربازه $s_l , s_{l+1} , \dots , s_r$ قرار میدهیم.
	طبق تعریف $dp[i][i] = 1$ است و اگر $s_i = s_{i+1}$ باشد $dp[i][i+1] = 2$ است و در غیر این صورت $dp[i][i+1] = 1$ است.
	حال برای $dp[l][r]$ سه حالت زیر را در نظر بگیرید.
	
	حالت 1: 
	
	  در بزرگترین زیر دنباله پالیندروم، $s_l$ نمی آید. در این حالت جواب برابر $dp[l+1][r]$ است.
	
	حالت 2:
	
	در بزرگترین زیر دنباله پالیندروم $s_r$ نمی آید. در این حالت جواب برابر $dp[l][r-1]$ است.
	
	حالت 3:
	
	در برگترین زیر دنباله پالیندروم هم $s_l$ و هم $s_r$ می آید. شرط این حالت این است که $s_l = s_r$ باشد. اگر این شرط برقرار باشد جواب این حالت برابر $dp[l][r] = max(dp[l+1][r],dp[l][r-1])$ است.
	
	واضح است که یکی از این سه حالت برقرار است لذا $dp[l][r] = max(dp[l+1][r],dp[l][r-1],(s[l] = s[r] ? dp[l+1][r-1] + 2 : 0) )$ است.
??? success "پیاده سازی"
	```cpp linenums="1"
	for(int i = 1; i <= n; i ++) {
		dp[i][i] = 1;
		if(i < n) dp[i][i+1] = (s[i] == s[i+1] ? 2 : 1);
	}
	for(int len = 3; len <= n ; len ++) {
		for(int l = 1 ;l +len-1 <= n ; l++) {
			int r = l + len-1;
			dp[l][r] = max({dp[l+1][r],dp[l][r-1],(s[l] == s[r] ? dp[l+1][r-1] + 2 : 0)});
		}
	}
	```
## سوال ها 
 <form name="cf-handel-form" class="cf-handel-form" onsubmit="return cf_status_checker()">
  <input type="text" id="cf-handel" name="cf-handel" class="handel-input" placeholder="هندل کدفرسز:"><br>
  <input type="submit" value="Submit" class="md-button cf-handel-button">
</form> | سوال | سختی | تگ ها | جاج | 
| :-----: | :----: | :----: | :----: | 
|[Queries for Number of Palindromes](https://codeforces.com/contest/245/problem/H){:target="_blank"}|1800|<details> <summary>Spoiler</summary> <ul><li>[dp بازه ای](/Level2/dplr){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Empty String](https://cses.fi/problemset/task/1080){:target="_blank"}|1900|<details> <summary>Spoiler</summary> <ul><li>[dp بازه ای](/Level2/dplr){:target="_blank"}</li></ul> </details>|:judge-cses: [CSES](https://cses.fi){:target="_blank"}|
|[هیتایوتا](https://quera.org/problemset/14933){:target="_blank"}|2400|<details> <summary>Spoiler</summary> <ul><li>[dp بازه ای](/Level2/dplr){:target="_blank"}</li></ul> </details>|:judge-quera: [Quera](https://quera.org){:target="_blank"}|
|[Trucks and Cities](https://codeforces.com/contest/1101/problem/F){:target="_blank"}|2600|<details> <summary>Spoiler</summary> <ul><li>[dp بازه ای](/Level2/dplr){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Zoning Restrictions](https://codeforces.com/problemset/problem/1146/G){:target="_blank"}|2700|<details> <summary>Spoiler</summary> <ul><li>[dp بازه ای](/Level2/dplr){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
