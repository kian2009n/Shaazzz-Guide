--- 
hide:
  - footer
comments: true
---
# محاسبه توان پیمانه دار

## توضیحات 
ما در بسیاری از مسائل  خصوصا در مسائل شمارشی نیازمندیم که توان را سریع و با مرتبه زمانی خوب محسابه کنیم ! در اینجا می‌خواهیم   الگوریتمی ارائه دهیم که در  $O(log(n))$  برای ما عملیات توان را انجام دهد. معمولا چون این عدد مقدار بزرگی است، آن را باقی مانده بر یک عدد ثابت $mod$ پیدا می‌کنیم.

### الگوریتم

ابتدا یک الگوریتم ضعیف تر را در نظر بگیرید که می‌خواهیم مقدار $a^x$ را حساب کنیم. راحت ترین کار این است که $x$ بار ضرب انجام دهیم و جواب را ذخیره کنیم و در نهایت جواب را خروجی دهیم. برای جزییات به کد زیر توجه کنید :

### کد

```cpp linenums="1"

long long a, x, mod = 1e9 + 7;

int main() {

    cin >> a >> x;

    long long res = 1;

    for(long long i=1; i<=x; i++) {
        res *= a;
        res %= mod;
    }

    cout << res << endl;

    return 0;

}

```


در اینجا پیچیدگی زمانی ما از $O(x)$ است که برای ما خیلی زمان بر و ناکاربردی است.


### مسئله
می‌خواهیم $a^x$ را باقی مانده بر $mod$ در پیچیدگی زمانی $O(log(x))$ حل کنیم. 

### راه حل
فرض کنید می‌دانیم جواب به ازای $a^{x/2}$ برابر با $r$ است و همچنین $x$ زوج است. حال می‌توانیم با استفاده از همین $a^x$ را محسابه کنیم که همان $r^2$ می‌شود. حال فرض کنید $x$ عددی فرد بود. آنگاه اگر $r$ برابر $a^{(x-1)/2}$ بود، پاسخ برابر بود با $r^2 * a$ . با استفاده از همین روش به صورت بازگشتی می‌توانیم $a^x$ را محسابه کنیم. برای جزییات به کد زیر توجه کنید.

### کد

```cpp linenums="1"

long long A, X, mod = 1e9 + 7;

long long poww(long long a, long long x) {
    if(x == 0) return 1;

    long long r = poww((a * a) % mod, x / 2); // (1)! 
    // (2)!

    if(x % 2 == 1) return (r * a) % mod;
    return r;
}

int main() {    
    cin >> A >> X;
    
    cout << poww(A, X) << endl;
    
    return 0 ;
}

```

1. چون $a*a$ انجام دادیم نیازی به محاسبه ی $r*r$ نیست.
2. $x/2$ خود به خود عملیات کف گیری انجام می‌دهد.

### یک کد راحت تر

می‌دانیم که $a^{x+y}$ برابر است با $a^x * a^y$. پس می‌توانیم عدد $x$ را در مبنای دو بنویسیم و به بیت های یک آن توجه کنیم. اگر بدانیم که $a^{2^i}$ چند است و بیت $i$ ام عدد $x$ یک باشد کافی است این عدد را با جواب ضرب کنیم. برای درک بهتر راه حل به کد زیر توجه کنید :

```cpp linenums="1"

long long A, X, mod = 1e9 + 7;

long long poww(long long a, long long x) {
    long long result = 1;
    while(x > 0) {
        if(x % 2 == 1) { // (1)!
            result = (result * a) % mod;
        }
        a = (a * a) % mod; // (2)!
        x /= 2;
    }
    return result;
}

int main() {    
    cin >> A >> X;
    
    cout << poww(A, X) << endl;
    
    return 0 ;
}

```

1. در اینجا چک می‌کنیم که بیت $i$ ام آن یک است یا خیر.
2. $a^{2^i} = a^{2^{i-1}} * a^{2^{i-1}}$

### کاربرد ها

خیلی وقت ها نیازمند آن هستیم که به کمک قضیه فرما یک تقسیم را باقی مانده بر یک عدد $mod$ انجام دهیم.
برای مثال اگر یک عدد $a$ باشد و بخواهیم $1/a$ را به دست بیاریم به پیمانه ی $mod$ باید $a^{mod-2}$ را به دست آوریم که اگر $mod$ عددی بزرگ باشد نیاز به یک الگوریتم سریع تر از $O(mod)$ داریم که می‌توان از روش بالا استفاده کرد. همچنین از این روش برای به توان رساندن ماتریس ها هم می‌توان کمک گرفت.

## سوال ها 
 <form name="cf-handel-form" class="cf-handel-form" onsubmit="return cf_status_checker()">
  <input type="text" id="cf-handel" name="cf-handel" class="handel-input" placeholder="هندل کدفرسز:"><br>
  <input type="submit" value="Submit" class="md-button cf-handel-button">
</form> | سوال | سختی | تگ ها | جاج | 
| :-----: | :----: | :----: | :----: | 
|[Count Good Numbers](https://leetcode.com/problems/count-good-numbers/description/){:target="_blank"}|1500|<details> <summary>Spoiler</summary> <ul><li>[محاسبه توان پیمانه دار](/Level2/power){:target="_blank"}</li></ul> </details>|:judge-leetcode: [LeetCode](https://leetcode.com/){:target="_blank"}|
|[Parking Lot](https://codeforces.com/problemset/problem/630/I){:target="_blank"}|1700|<details> <summary>Spoiler</summary> <ul><li>[محاسبه توان پیمانه دار](/Level2/power){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
