--- 
hide:
  - footer
comments: true
---
# LIS و LCS

## توضیحات 
در این بخش دو مسئله‌ی کلاسیک [برنامه‌نویسی پویا](/Level2/dp/) روی دنباله‌ها را بررسی می‌کنیم: بلندترین زیردنباله‌ی صعودی (LIS) و بلندترین زیردنباله‌ی مشترک (LCS). زیردنباله‌ی یک آرایه به آرایه‌ای گفته می‌شود که با حذف تعدادی از اعضا و حفظ ترتیب بقیه به دست می‌آید؛ مثلا برای $[1, 2, 3]$ آرایه‌های $[]$، $[1]$، $[1, 3]$ و $[1, 2, 3]$ زیردنباله هستند ولی $[2, 1]$ و $[4]$ نیستند.

### بلندترین زیردنباله‌ی صعودی

#### مسئله

آرایه‌ی $a_1, a_2, \dots, a_N$ به طول $N$ $(1 \leq N \leq 10^6)$ داده شده است که $1 \leq a_i \leq 10^9$. طول بلندترین زیردنباله‌ی اکیدا صعودی آن (یعنی $b_1 < b_2 < \dots < b_K$) چقدر است؟

#### راه حل $O(N^2)$

اولین تعریفی که به ذهن می‌رسد این است: $f[i]$ طول بلندترین زیردنباله‌ی صعودی‌ای باشد که **به $a_i$ ختم می‌شود**. برای محاسبه‌ی $f[i]$ باید عضو قبل از $a_i$ در زیردنباله را انتخاب کنیم؛ این عضو یک $a_j$ با $j < i$ و $a_j < a_i$ است و بهترین انتخاب، آن $j$ای است که $f[j]$ بیشینه باشد:

$$f[i] = 1 + \max_{j < i,\ a_j < a_i} f[j]$$

اگر چنین $j$ای وجود نداشته باشد، $f[i] = 1$ است (زیردنباله‌ای که فقط خود $a_i$ است). جواب مسئله بیشینه‌ی همه‌ی $f[i]$هاست، چون بلندترین زیردنباله به یکی از اعضا ختم می‌شود.

```cpp linenums="1"

vector<int> f(n + 1, 1);
for (int i = 1; i <= n; i++)
    for (int j = 1; j < i; j++)
        if (a[j] < a[i]) // (1)!
            f[i] = max(f[i], f[j] + 1);

cout << *max_element(f.begin() + 1, f.end()) << endl;
```

1. فقط $j$هایی مجازند که $a_j < a_i$ باشد تا زیردنباله صعودی بماند.

این راه $O(N^2)$ است و برای $N \leq 10^4$ کافی است، اما برای $N = 10^6$ خیلی کند است. در ادامه با تغییر تعریف $dp$ به $O(N \log N)$ می‌رسیم.

!!! tip "نکته"
    این تعریف («بهترین جوابی که به عضو $i$ ختم می‌شود») الگویی است که در خیلی از سوالات دیگر دی‌پی روی دنباله‌ها هم تکرار می‌شود و ارزش دارد آن را خوب یاد بگیرید.

#### راه حل $O(N \log N)$

آرایه‌ی $dp$ را با این تعریف می‌سازیم: $dp[i]$ کوچک‌ترین عددی است که یک زیردنباله‌ی صعودی به طول $i$ (بین اعضایی که تا حالا دیده‌ایم) می‌تواند به آن ختم شود. در ابتدا $dp[0] = 0$ و بقیه‌ی خانه‌ها بی‌نهایت هستند، چون هنوز هیچ زیردنباله‌ای با طول بیشتر از صفر نداریم. سپس روی آرایه‌ی $a$ حرکت می‌کنیم و $dp$ را به‌روز می‌کنیم. در پایان، جواب اندیس آخرین خانه‌ی غیر بی‌نهایت است.

ادعا می‌کنیم آرایه‌ی $dp$ همیشه اکیدا صعودی است.

??? success "اثبات"
    فرض خلف کنید $j$ای وجود دارد که $dp[j] \leq dp[j-1]$. زیردنباله‌ی طول $j$ که به $dp[j]$ ختم می‌شود را در نظر بگیرید و عضو آخر آن را حذف کنید. زیردنباله‌ای به طول $j-1$ می‌ماند که عضو آخرش اکیدا کوچک‌تر از $dp[j]$ و در نتیجه کوچک‌تر از $dp[j-1]$ است؛ این با کمینه بودن $dp[j-1]$ در تناقض است.

حال فرض کنید به $a_i$ رسیده‌ایم. $j$ را اولین اندیسی بگیرید که $dp[j] \geq a_i$ است. ادعا می‌کنیم تنها خانه‌ای که تغییر می‌کند $dp[j]$ است و مقدار جدید آن $a_i$ می‌شود.

??? success "اثبات"
    طبق تعریف $j$، داریم $dp[j-1] < a_i$. پس اگر $a_i$ را به انتهای زیردنباله‌ی طول $j-1$ اضافه کنیم، یک زیردنباله‌ی طول $j$ با انتهای $a_i$ ساخته‌ایم و چون $a_i \leq dp[j]$ است، $dp[j]$ به $a_i$ تغییر می‌کند.

    خانه‌های $dp[0], \dots, dp[j-1]$ همه از $a_i$ کوچک‌ترند، پس زیردنباله‌ای که به $a_i$ ختم شود نمی‌تواند آن‌ها را بهتر کند. برای خانه‌های $dp[j+1]$ به بعد هم باید زیردنباله‌ای به طول حداقل $j$ با انتهای کوچک‌تر از $a_i$ داشته باشیم که طبق تعریف $j$ وجود ندارد.

چون $dp$ صعودی است، اندیس $j$ را می‌توان با [باینری سرچ](/Level1/binary_search/) پیدا کرد.

#### پیچیدگی زمانی

به ازای هر عضو یک باینری سرچ از $O(\log N)$ انجام می‌دهیم، پس کل راه حل $O(N \log N)$ است.

#### کد

```cpp linenums="1"

const int INF = 1e9 + 23;

int main() {
    int n;
    cin >> n;

    vector<int> a(n + 1);
    for (int i = 1; i <= n; i++)
        cin >> a[i];

    vector<int> dp(n + 1, INF);
    dp[0] = 0;

    for (int i = 1; i <= n; i++) {
        int j = lower_bound(dp.begin(), dp.end(), a[i]) - dp.begin(); // (1)!
        dp[j] = a[i];
    }

    int ans = 0;
    while (ans + 1 <= n && dp[ans + 1] != INF) ans++;
    cout << ans << endl;
}
```

1. تابع `#!cpp lower_bound` اولین خانه‌ای را برمی‌گرداند که مقدارش بزرگ‌تر یا مساوی `#!cpp a[i]` است؛ همان $j$ در توضیحات.

!!! tip "نکته"
    اگر صعودی نااکید (با $\leq$) بخواهیم، به جای `#!cpp lower_bound` از `#!cpp upper_bound` استفاده می‌کنیم.

#### به دست آوردن خود زیردنباله

دقت کنید که آرایه‌ی $dp$ خودش زیردنباله‌ی جواب **نیست**؛ فقط انتهای بهترین زیردنباله‌ی هر طول را نگه می‌دارد و ممکن است اعضای آن از زیردنباله‌های متفاوتی آمده باشند. برای ساختن جواب دو چیز را برای هر $i$ ذخیره می‌کنیم: طول زیردنباله‌ای که به $a_i$ ختم می‌شود (همان $j$) و اندیس عضوی که در آن لحظه در $dp[j-1]$ قرار داشت. پس باید به جای مقدار، **اندیس** را در $dp$ نگه داریم. در پایان از عضو آخر بلندترین زیردنباله به عقب برمی‌گردیم.

```cpp linenums="1"

vector<int> pos(n + 1, 0), len(n + 1), par(n + 1); // (1)!
int best = 0;

for (int i = 1; i <= n; i++) {
    int lo = 1, hi = best + 1; // (2)!
    while (lo < hi) {
        int mid = (lo + hi) / 2;
        if (a[pos[mid]] >= a[i]) hi = mid;
        else lo = mid + 1;
    }
    int j = lo;
    pos[j] = i;
    len[i] = j;
    par[i] = pos[j - 1]; // (3)!
    best = max(best, j);
}

vector<int> ans;
for (int i = pos[best]; i != 0; i = par[i]) // (4)!
    ans.push_back(a[i]);
reverse(ans.begin(), ans.end());
```

1. `#!cpp pos[j]` اندیس عضوی است که الان در $dp[j]$ قرار دارد، `#!cpp len[i]` طول زیردنباله‌ی ختم‌شده به $a_i$ و `#!cpp par[i]` اندیس عضو قبلی آن است.

2. چون در `#!cpp pos` اندیس نگه می‌داریم و نه مقدار، `#!cpp lower_bound` مستقیما قابل استفاده نیست و باینری سرچ را دستی روی مقدارهای `#!cpp a[pos[mid]]` انجام می‌دهیم.

3. عضو قبلیِ $a_i$ در زیردنباله، همان چیزی است که در لحظه‌ی پردازش $a_i$ در $dp[j-1]$ بوده است. چون $dp[j-1]$ بعدا ممکن است تغییر کند، باید همین الان آن را ذخیره کنیم.

4. از انتهای بلندترین زیردنباله شروع می‌کنیم و با `#!cpp par` به عقب می‌رویم؛ `#!cpp pos[0] = 0` نقش «انتهای مسیر» را دارد.

### بلندترین زیردنباله‌ی مشترک

#### مسئله

دو رشته‌ی $s$ و $t$ با طول حداکثر $10^3$ داده شده‌اند. بلندترین رشته‌ای که زیردنباله‌ی هر دو باشد چه طولی دارد؟

#### راه حل

$dp[i][j]$ را برابر طول بلندترین زیردنباله‌ی مشترک $i$ کاراکتر اول $s$ و $j$ کاراکتر اول $t$ تعریف می‌کنیم.

**پایه:** اگر یکی از دو رشته خالی باشد جواب صفر است؛ پس $dp[0][j] = dp[i][0] = 0$.

**رابطه‌ی بازگشتی:** کاراکتر $i$ام $s$ و کاراکتر $j$ام $t$ را در نظر بگیرید.

+ اگر $s_i \neq t_j$ باشد، این دو نمی‌توانند هر دو در جواب باشند (اگر هر دو در جواب بودند، چون آخرین کاراکترها هستند باید با هم جفت می‌شدند و برابر می‌بودند). پس حداقل یکی از آن‌ها کنار گذاشته می‌شود:

$$dp[i][j] = \max(dp[i-1][j],\ dp[i][j-1])$$

+ اگر $s_i = t_j$ باشد، علاوه بر دو حالت بالا می‌توانیم این دو را با هم جفت کنیم و به جواب $i-1$ و $j-1$ کاراکتر اول یکی اضافه کنیم:

$$dp[i][j] = \max(dp[i-1][j],\ dp[i][j-1],\ dp[i-1][j-1] + 1)$$

جواب مسئله $dp[|s|][|t|]$ است.

#### پیچیدگی زمانی

هر خانه در $O(1)$ محاسبه می‌شود، پس کل راه حل $O(|s| \times |t|)$ است.

#### کد

```cpp linenums="1"

int main() {
    string s, t;
    cin >> s >> t;

    int n = s.size(), m = t.size();
    vector<vector<int>> dp(n + 1, vector<int>(m + 1, 0));

    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= m; j++) {
            dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]);
            if (s[i - 1] == t[j - 1]) // (1)!
                dp[i][j] = max(dp[i][j], dp[i - 1][j - 1] + 1);
        }

    cout << dp[n][m] << endl;
}
```

1. چون اندیس رشته‌ها در <span dir="ltr">C++</span> از صفر شروع می‌شود، کاراکتر $i$ام همان `#!cpp s[i - 1]` است.

#### به دست آوردن خود زیردنباله

برای ساختن خود جواب، برای هر خانه نگه می‌داریم که از کدام یک از $dp[i-1][j-1]$، $dp[i-1][j]$ یا $dp[i][j-1]$ به‌روز شده است. سپس از $dp[|s|][|t|]$ شروع می‌کنیم و به عقب حرکت می‌کنیم؛ هر جا که از $dp[i-1][j-1]$ آمده بودیم، یعنی $s_i$ و $t_j$ با هم جفت شده‌اند و آن‌ها را به جواب اضافه می‌کنیم.

```cpp linenums="1"

int main() {
    string s, t;
    cin >> s >> t;

    int n = s.size(), m = t.size();
    vector<vector<int>> dp(n + 1, vector<int>(m + 1, 0));
    vector<vector<pair<int, int>>> par(n + 1, vector<pair<int, int>>(m + 1)); // (1)!

    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= m; j++) {
            if (dp[i - 1][j] < dp[i][j - 1]) {
                dp[i][j] = dp[i][j - 1];
                par[i][j] = {i, j - 1};
            } else {
                dp[i][j] = dp[i - 1][j];
                par[i][j] = {i - 1, j};
            }
            if (s[i - 1] == t[j - 1] && dp[i][j] < dp[i - 1][j - 1] + 1) {
                dp[i][j] = dp[i - 1][j - 1] + 1;
                par[i][j] = {i - 1, j - 1};
            }
        }

    vector<int> a, b; // (2)!
    int x = n, y = m;
    while (x != 0 && y != 0) {
        auto [i, j] = par[x][y];
        if (i == x - 1 && j == y - 1) {
            a.push_back(x);
            b.push_back(y);
        }
        x = i, y = j;
    }

    reverse(a.begin(), a.end());
    reverse(b.begin(), b.end());

    for (int id : a) cout << id << ' ';
    cout << endl;
    for (int id : b) cout << id << ' ';
    cout << endl;
}
```

1. در `#!cpp par[i][j]` نگه می‌داریم که $dp[i][j]$ از روی کدام خانه به‌روز شده است.

2. اندیس‌های انتخاب‌شده از $s$ را در `#!cpp a` و از $t$ را در `#!cpp b` نگه می‌داریم.

!!! tip "LCS دو جایگشت"
    اگر $s$ و $t$ هر دو جایگشتی از $1$ تا $n$ باشند (یعنی هر عدد در هر کدام دقیقا یک بار آمده باشد)، می‌توان LCS را در $O(n \log n)$ حساب کرد. هر عدد $x$ را با مکانش در $t$ جایگزین کنید: اگر $x$ در خانه‌ی $k$ام $t$ باشد، به جای آن در $s$ عدد $k$ را بنویسید. حالا یک زیردنباله‌ی مشترک $s$ و $t$ دقیقا معادل یک زیردنباله از آرایه‌ی جدید است که مکان‌هایش در $t$ صعودی باشد؛ یعنی LCS دو جایگشت همان LIS آرایه‌ی جدید است.

### فاصله‌ی ویرایشی

#### مسئله

دو رشته‌ی $s$ و $t$ داده شده‌اند. در هر مرحله می‌توانیم یک کاراکتر $s$ را حذف کنیم، یک کاراکتر در جایی از آن اضافه کنیم یا یک کاراکتر را به کاراکتر دیگری تغییر دهیم. کمترین تعداد مراحل برای تبدیل $s$ به $t$ چقدر است؟ به این عدد فاصله‌ی ویرایشی (Edit Distance) می‌گویند.

#### راه حل

این مسئله خویشاوند نزدیک LCS است و دقیقا با همان حالت‌ها حل می‌شود. $dp[i][j]$ را کمترین تعداد عمل برای تبدیل $i$ کاراکتر اول $s$ به $j$ کاراکتر اول $t$ تعریف می‌کنیم.

**پایه:** تبدیل رشته‌ی خالی به $j$ کاراکتر، $j$ عمل اضافه کردن می‌خواهد و تبدیل $i$ کاراکتر به رشته‌ی خالی، $i$ عمل حذف؛ پس $dp[0][j] = j$ و $dp[i][0] = i$.

**رابطه‌ی بازگشتی:** به آخرین کاراکترها یعنی $s_i$ و $t_j$ نگاه می‌کنیم. یکی از این سه اتفاق برای $s_i$ می‌افتد:

+ حذف می‌شود: $1 + dp[i-1][j]$.
+ بعد از آن یک کاراکتر برابر $t_j$ اضافه می‌شود: $1 + dp[i][j-1]$.
+ با $t_j$ جفت می‌شود: اگر $s_i = t_j$ هزینه‌ای ندارد و در غیر این صورت یک تغییر لازم است، یعنی $dp[i-1][j-1] + [s_i \neq t_j]$.

مقدار $dp[i][j]$ کمینه‌ی این سه حالت است و جواب $dp[|s|][|t|]$ است. مثل LCS، زمان و حافظه $O(|s| \times |t|)$ است.

```cpp linenums="1"

vector<vector<int>> dp(n + 1, vector<int>(m + 1));
for (int i = 0; i <= n; i++) dp[i][0] = i;
for (int j = 0; j <= m; j++) dp[0][j] = j;

for (int i = 1; i <= n; i++)
    for (int j = 1; j <= m; j++) {
        dp[i][j] = min(dp[i - 1][j], dp[i][j - 1]) + 1; // (1)!
        dp[i][j] = min(dp[i][j], dp[i - 1][j - 1] + (s[i - 1] != t[j - 1])); // (2)!
    }

cout << dp[n][m] << endl;
```

1. حذف $s_i$ یا اضافه کردن $t_j$؛ هر کدام یک عمل.

2. جفت کردن $s_i$ با $t_j$؛ عبارت `#!cpp (s[i - 1] != t[j - 1])` وقتی دو کاراکتر فرق دارند برابر $1$ و در غیر این صورت $0$ است.

!!! tip "نکته"
    مقایسه کنید: در LCS می‌خواهیم جفت‌شدن‌های برابر را **بیشینه** کنیم و در فاصله‌ی ویرایشی می‌خواهیم حذف، اضافه و تغییرها را **کمینه** کنیم؛ ولی ساختار جدول و سه حالت گذار در هر دو یکی است. بسیاری از سوالات روی دو رشته با همین جدول $(i, j)$ حل می‌شوند.

### منابع بیشتر

+ [Longest Increasing Subsequence](https://cp-algorithms.com/sequences/longest_increasing_subsequence.html)
+ [Longest Common Subsequence](https://www.geeksforgeeks.org/longest-common-subsequence-dp-4/)

## سوال ها 
 <form name="cf-handel-form" class="cf-handel-form" onsubmit="return cf_status_checker()">
  <input type="text" id="cf-handel" name="cf-handel" class="handel-input" placeholder="هندل کدفرسز:"><br>
  <input type="submit" value="Submit" class="md-button cf-handel-button">
</form> | سوال | سختی | تگ ها | جاج | 
| :-----: | :----: | :----: | :----: | 
|[Towers](https://cses.fi/problemset/task/1073){:target="_blank"}|1100|<details> <summary>Spoiler</summary> <ul><li>[LIS و LCS](/Level2/lis_lcs){:target="_blank"}</li></ul> </details>|:judge-cses: [CSES](https://cses.fi){:target="_blank"}|
|[North-East](https://codeforces.com/problemsets/acmsguru/problem/99999/521){:target="_blank"}|1200|<details> <summary>Spoiler</summary> <ul><li>[LIS و LCS](/Level2/lis_lcs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [SGU](https://codeforces.com/problemsets/acmsguru){:target="_blank"}|
|[Consecutive Subsequence](https://codeforces.com/contest/977/problem/F){:target="_blank"}|1400|<details> <summary>Spoiler</summary> <ul><li>[LIS و LCS](/Level2/lis_lcs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[LCS on Permutations](https://codeforces.com/gym/102951/problem/C){:target="_blank"}|1500|<details> <summary>Spoiler</summary> <ul><li>[LIS و LCS](/Level2/lis_lcs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Gym](https://codeforces.com/gyms){:target="_blank"}|
|[Cow Jog](https://usaco.org/index.php?page=viewproblem2&cpid=496){:target="_blank"}|1700|<details> <summary>Spoiler</summary> <ul><li>[LIS و LCS](/Level2/lis_lcs){:target="_blank"}</li></ul> </details>|:judge-usaco: [Usaco](https://usaco.org){:target="_blank"}|
|[ Korney Korneevich and XOR (easy version)](https://codeforces.com/contest/1582/problem/F1){:target="_blank"}|1700|<details> <summary>Spoiler</summary> <ul><li>[LIS و LCS](/Level2/lis_lcs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[LCIS](https://codeforces.com/contest/10/problem/D){:target="_blank"}|1900|<details> <summary>Spoiler</summary> <ul><li>[LIS و LCS](/Level2/lis_lcs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Tourist](https://codeforces.com/contest/76/problem/F){:target="_blank"}|2000|<details> <summary>Spoiler</summary> <ul><li>[LIS و LCS](/Level2/lis_lcs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Global Warming](https://oj.uz/problem/view/CEOI18_glo){:target="_blank"}|2400|<details> <summary>Spoiler</summary> <ul><li>[LIS و LCS](/Level2/lis_lcs){:target="_blank"}</li></ul> </details>|:judge-ojuz: [Oj.uz](https://oj.uz){:target="_blank"}|
