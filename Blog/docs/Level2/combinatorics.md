--- 
hide:
  - footer
comments: true
---
# انتخاب و سوالات ترکیبیاتی

## توضیحات 
### تابع nCr در ++C

تابع $nCr$ یا ترکیب، نشان‌دهنده‌ی تعداد روش‌های انتخاب $r$ عنصر از بین $n$ عنصر بدون در نظر گرفتن ترتیب است. فرمول آن به شکل زیر است:

$$
C(n, r) = \binom{n}{r} = \frac{n!}{r!(n-r)!}
$$

---

### مسئله

می‌خواهیم در ++C تابعی بنویسیم که مقدار $nCr$ را برای $n$ و $r$ دلخواه محاسبه کند.


!!! danger "مشکل"
برای مقادیر بزرگ $n$، فاکتوریل‌ها خیلی سریع رشد می‌کنند و باعث **سرریز (overflow)** خواهند شد. پس این روش برای اعداد بزرگ مناسب نیست.

---


###  محاسبه با تقسیم تدریجی

برای جلوگیری از overflow و محاسبه‌ی سریع‌تر می‌توانیم از روش زیر استفاده کنیم:

$$
C(n, r) = \frac{n}{1} \times \frac{n-1}{2} \times \frac{n-2}{3} \times \dots \times \frac{n-r+1}{r}
$$

```cpp linenums="1"
long long nCr(int n, int r) {
    if (r > n) return 0;
    if (r > n - r) r = n - r; // بهینه‌سازی
    long long res = 1;
    for (int i = 1; i <= r; i++) {
        res = res * (n - r + i) / i;
    }
    return res;
}
```

!!! info "نکته"
مزیت این روش این است که در هر مرحله تقسیم انجام می‌دهیم تا عدد خیلی بزرگ نشود.

---

### ایده اصلی

برای محاسبه‌ی سریع:

$$
C(n, r) = \frac{fact[n]}{fact[r] \cdot fact[n-r]}
$$

در حالتی که باید به پیمانه‌ای ذخیره کنیم :

$$
C(n, r) = fact[n] \times invfact[r] \times invfact[n-r] \pmod{MOD}
$$

که در آن:

* $fact[i] = i! \pmod{MOD}$
* $invfact[i] = (i!)^{-1} \pmod{MOD}$*

---

### چرا معکوس نگه می‌داریم؟

برای تقسیم در حساب پیمانه‌ای، تقسیم مستقیم امکان‌پذیر نیست. باید به جای آن از **معکوس پیمانه‌ای** استفاده کنیم:

$$
\frac{a}{b} \equiv a \times b^{-1} \pmod{MOD}
$$

از آنجایی که محاسبه‌ی معکوس برای هر پرس‌وجو زمان‌بر است، یک بار تمام معکوس‌ها را پیش‌محاسبه می‌کنیم و در آرایه `invfact` نگه می‌داریم. به این ترتیب:

* پیش‌محاسبه در $O(n)$
* هر پرسش $O(1)$

---
### تابع nCr در ++C 

تابع $nCr$ یا ترکیب، تعداد روش‌های انتخاب $r$ عنصر از بین $n$ عنصر است. فرمول آن به شکل زیر است:

$$
C(n, r) = \binom{n}{r} = \frac{n!}{r!(n-r)!}
$$


### قضیه کوچک فرما و محاسبه معکوس

چون $MOD$ عدد **اول** است، می‌توانیم از **قضیه کوچک فرما** استفاده کنیم:

$$
a^{MOD-1} \equiv 1 \pmod{MOD} \quad (a \not\equiv 0 \pmod{MOD})
$$

با تقسیم هر دو طرف بر $a$:

$$
a^{MOD-2} \equiv a^{-1} \pmod{MOD}
$$

بنابراین معکوس پیمانه‌ای یک عدد $a$ برابر است با توان $MOD-2$ آن به پیمانه $MOD$. برای همین در کد زیر از تابع `modpow(a, MOD-2)` استفاده می‌کنیم.

---

### کد کامل

```cpp linenums="1"
#include <bits/stdc++.h>
using namespace std;

const int MOD = 1e9+7;
const int MAX = 1e6 + 5; // حداکثر n
long long fact[MAX], invfact[MAX];

long long modpow(long long a, long long b) {
    long long res = 1;
    while (b) {
        if (b & 1) res = res * a % MOD;
        a = a * a % MOD;
        b >>= 1;
    }
    return res;
}

void init() {
    fact[0] = 1;
    for (int i = 1; i < MAX; i++) fact[i] = fact[i-1] * i % MOD;

    // محاسبه معکوس فاکتوریل بزرگترین عدد
    invfact[MAX-1] = modpow(fact[MAX-1], MOD-2);

    // پر کردن بقیه معکوس‌ها به صورت نزولی
    for (int i = MAX-2; i >= 0; i--) {
        invfact[i] = invfact[i+1] * (i+1) % MOD;
    }
}

long long nCr(int n, int r) {
    if (r > n || r < 0) return 0;
    return fact[n] * invfact[r] % MOD * invfact[n-r] % MOD;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    init(); // پیش محاسبه

    cout << nCr(5, 2) << "\n";   // خروجی: 10
    cout << nCr(10, 3) << "\n";  // خروجی: 120
    cout << nCr(1000000, 500000) << "\n"; // سریع در O(1)
}
```

---

### نکته مهم

* استفاده از قضیه کوچک فرما فقط زمانی معتبر است که $MOD$ **اول** باشد.
* اگر $MOD$ اول نباشد، باید از روش‌هایی مثل الگوریتم توسعه‌یافته‌ی اقلیدس برای محاسبه‌ی معکوس استفاده کرد.


---
### منابع بیشتر

* [Binomial Coefficient - CP Algorithms](https://cp-algorithms.com/combinatorics/binomial-coefficients.html)
* [nCr and Modular Inverse](https://codeforces.com/blog/entry/63711)
* [Fermat’s Little Theorem](https://en.wikipedia.org/wiki/Fermat%27s_little_theorem)


## سوال ها 
 <form name="cf-handel-form" class="cf-handel-form" onsubmit="return cf_status_checker()">
  <input type="text" id="cf-handel" name="cf-handel" class="handel-input" placeholder="هندل کدفرسز:"><br>
  <input type="submit" value="Submit" class="md-button cf-handel-button">
</form> | سوال | سختی | تگ ها | جاج | 
| :-----: | :----: | :----: | :----: | 
|[Combinations](https://leetcode.com/problems/combinations/){:target="_blank"}|1000|<details> <summary>Spoiler</summary> <ul><li>[توابع بازگشتی](/Level1/recursive){:target="_blank"}</li> <li>[انتخاب و سوالات ترکیبیاتی](/Level2/combinatorics){:target="_blank"}</li></ul> </details>|:judge-leetcode: [LeetCode](https://leetcode.com/){:target="_blank"}|
