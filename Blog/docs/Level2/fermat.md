--- 
hide:
  - footer
comments: true
---
# قضیه کوچک فرما و وارون ضربی

## توضیحات 
در این بخش با [قضیه‌ی کوچک فرما](https://fa.wikipedia.org/wiki/%D9%82%D8%B6%DB%8C%D9%87_%DA%A9%D9%88%DA%86%DA%A9_%D9%81%D8%B1%D9%85%D8%A7) و یکی از مهم‌ترین کاربردهای آن، یعنی محاسبه‌ی وارون ضربی و تقسیم به پیمانه‌ی یک عدد اول، آشنا می‌شویم.

### قضیه‌ی کوچک فرما

اگر $p$ عددی اول و $a$ عددی صحیح باشد که بر $p$ بخش‌پذیر نیست، آنگاه:

$$a^{p-1} \equiv 1 \pmod{p}$$

این قضیه را به شکل $a^p \equiv a \pmod{p}$ هم بیان می‌کنند که در این حالت برای هر $a$ صحیح برقرار است.

??? success "اثبات"
    یک گراف با $p-1$ راس می‌سازیم که راس‌های آن اعداد $1, 2, \dots, p-1$ هستند و از راس $v$ به راس $v \times a \bmod p$ یک یال جهت‌دار می‌گذاریم.

    درجه‌ی خروجی هر راس این گراف $1$ است. ادعا می‌کنیم درجه‌ی ورودی هر راس هم $1$ است. فرض کنید راس $z$ وجود دارد که درجه‌ی ورودی آن حداقل $2$ است، یعنی دو راس متفاوت $x$ و $y$ داریم که:

    $$x \times a \equiv z \pmod{p}, \quad y \times a \equiv z \pmod{p}$$

    اگر این دو را از هم کم کنیم، به $a(x-y) \equiv 0 \pmod{p}$ می‌رسیم. چون $a$ بر $p$ بخش‌پذیر نیست، $x-y$ باید بر $p$ بخش‌پذیر باشد؛ یعنی $x \equiv y \pmod{p}$ که با متفاوت بودن $x$ و $y$ در تناقض است.

    گرافی که درجه‌ی ورودی و خروجی هر راس آن $1$ است، اجتماع تعدادی دور مجزاست (به چنین گرافی گراف جایگشت می‌گویند). فرض کنید کوتاه‌ترین دور این گراف $C$ و $v$ یکی از راس‌های آن باشد. اگر از $v$ به اندازه‌ی $|C|$ قدم جلو برویم، دوباره به $v$ می‌رسیم. پس:

    $$v \times a^{|C|} \equiv v \pmod{p} \Rightarrow a^{|C|} \equiv 1 \pmod{p}$$

    حال نشان می‌دهیم طول همه‌ی دورها برابر $|C|$ است. فرض کنید دور $D$ با $|D| > |C|$ وجود دارد و $u$ یکی از راس‌های آن است. چون $a^{|C|} \equiv 1 \pmod{p}$، اگر از $u$ به اندازه‌ی $|C|$ قدم جلو برویم باید به خود $u$ برسیم؛ اما چون $|D| > |C|$ است، به راسی غیر از $u$ می‌رسیم که تناقض است.

    پس اگر گراف $t$ دور داشته باشد، $t \times |C| = p-1$ است؛ یعنی $p-1$ مضربی از طول دورهاست. بنابراین اگر از راس $v$ شروع کنیم و $p-1$ قدم جلو برویم، دوباره به $v$ می‌رسیم:

    $$v \times a^{p-1} \equiv v \pmod{p} \Rightarrow a^{p-1} \equiv 1 \pmod{p}$$

### وارون ضربی

وارون ضربی عدد $a$ به پیمانه‌ی $p$ که آن را با $a^{-1}$ نشان می‌دهیم، عددی است که اگر در $a$ ضرب شود، حاصل به پیمانه‌ی $p$ برابر $1$ شود:

$$a \times a^{-1} \equiv 1 \pmod{p}$$

می‌توان ثابت کرد که $a$ دقیقا زمانی وارون ضربی دارد که $a$ و $p$ نسبت به هم اول باشند. اگر $p$ اول باشد، طبق قضیه‌ی کوچک فرما $a^{p-1} \equiv 1 \pmod{p}$ است و چون $a^{p-1} = a \times a^{p-2}$، داریم:

$$a \times a^{p-2} \equiv 1 \pmod{p}$$

پس وارون ضربی $a$ به پیمانه‌ی $p$ برابر $a^{p-2}$ است و می‌توانیم آن را با [توان دودویی](/Level2/power/) در $O(\log p)$ حساب کنیم.

!!! warning ""
    اگر $a$ بر $p$ بخش‌پذیر باشد (یعنی $a \equiv 0 \pmod p$)، وارون ضربی وجود ندارد؛ چون هیچ عددی در $0$ ضرب نمی‌شود که $1$ بدهد. کدهای زیر در این حالت بدون هیچ خطایی مقدار $0$ برمی‌گردانند، پس اگر ممکن است $a$ مضرب $p$ باشد، باید خودتان این حالت را جدا بررسی کنید. به همین دلیل در تقسیم $\frac{x}{y}$ هم باید $y$ بر $p$ بخش‌پذیر نباشد.

### کد

#### روش بازگشتی

```cpp linenums="1"

long long power(long long a, long long b, long long p) {
    if (b == 0) return 1;
    long long res = power(a * a % p, b / 2, p);
    if (b % 2) res = res * a % p;
    return res;
}

long long inverse(long long a, long long p) {
    return power(a, p - 2, p);
}
```

#### روش غیربازگشتی

```cpp linenums="1"

long long inverse(long long a, long long p) {
    long long res = 1, b = p - 2;
    while (b) {
        if (b % 2) res = res * a % p;
        a = a * a % p;
        b /= 2;
    }
    return res;
}
```

### تقسیم به پیمانه‌ی $p$

برای محاسبه‌ی $\frac{x}{y}$ به پیمانه‌ی $p$ کافی است $x$ را در وارون ضربی $y$ ضرب کنیم:

$$\frac{x}{y} \equiv x \times y^{-1} \equiv x \times y^{p-2} \pmod{p}$$

??? success "مثال"
    می‌خواهیم $\frac{10}{2}$ را به پیمانه‌ی $7$ حساب کنیم:

    $$\frac{10}{2} \equiv 10 \times 2^{5} \equiv 320 \equiv 5 \pmod{7}$$

!!! warning ""
    این روش فقط وقتی کار می‌کند که $p$ اول باشد. برای پیمانه‌های غیر اول باید از [تابع فی اویلر](/Level2/Euler'sTotientFunction/) یا الگوریتم اقلیدس توسعه‌یافته استفاده کرد.

### منابع بیشتر

+ [Modular Inverse](https://cp-algorithms.com/algebra/module-inverse.html)
+ [قضیه‌ی کوچک فرما در ویکی‌پدیا](https://fa.wikipedia.org/wiki/%D9%82%D8%B6%DB%8C%D9%87_%DA%A9%D9%88%DA%86%DA%A9_%D9%81%D8%B1%D9%85%D8%A7)

## سوال ها 
 <form name="cf-handel-form" class="cf-handel-form" onsubmit="return cf_status_checker()">
  <input type="text" id="cf-handel" name="cf-handel" class="handel-input" placeholder="هندل کدفرسز:"><br>
  <input type="submit" value="Submit" class="md-button cf-handel-button">
</form> | سوال | سختی | تگ ها | جاج | 
| :-----: | :----: | :----: | :----: | 
|[Modular Inverse](https://www.geeksforgeeks.org/problems/modular-multiplicative-inverse-1587115620/1){:target="_blank"}|1200|<details> <summary>Spoiler</summary> <ul><li>[قضیه کوچک فرما و وارون ضربی](/Level2/fermat){:target="_blank"}</li></ul> </details>|:judge-gfg: [GeeksForGeeks](https://www.geeksforgeeks.org/){:target="_blank"}|
|[Exponentiation 2](https://cses.fi/ckvo8q5wh/task/1712){:target="_blank"}|1500|<details> <summary>Spoiler</summary> <ul><li>[قضیه کوچک فرما و وارون ضربی](/Level2/fermat){:target="_blank"}</li></ul> </details>|:judge-cses: [CSES](https://cses.fi){:target="_blank"}|
|[Two Arrays](https://codeforces.com/problemset/problem/1288/C){:target="_blank"}|1600|<details> <summary>Spoiler</summary> <ul><li>[قضیه کوچک فرما و وارون ضربی](/Level2/fermat){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Beautiful Numbers](https://codeforces.com/problemset/problem/300/C){:target="_blank"}|1800|<details> <summary>Spoiler</summary> <ul><li>[قضیه کوچک فرما و وارون ضربی](/Level2/fermat){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Inversion Expectation](https://codeforces.com/problemset/problem/1096/F){:target="_blank"}|2300|<details> <summary>Spoiler</summary> <ul><li>[قضیه کوچک فرما و وارون ضربی](/Level2/fermat){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
