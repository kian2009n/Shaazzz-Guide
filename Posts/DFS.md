--- 
hide:
  - footer
comments: true
---

## نحوه ذخیره گراف :‌
ما برای نگه داشتن یال ها به سه صورت کلی ممکن است یال ها را نگه داریم که هر کدام از این راه ها کاربرد های خود را داشته اند.
### روش اول :‌ پرکاربرد ترین
ما برای هر راس لیست همسایه های این راس را درون وکتور نگه میداریم و میتوانیم داده های دیگر مانند وزن یال و ... را با کمک pair نگه داریم
```cpp linenums="1"

vector <int> G[maxn] ; //‌ (1)!
vector <pair<int,int> > G2[maxn] ; // (2)!

int main(){
    int n , m ;
    cin >> n >> m ;
    for(int i =1 ; i<= m ; i++){// (3)!
        int v,  u, w ;
        cin >> v >> u >> w ;
        G[v].push_back(u) ;
        G[u].push_back(v) ;
        
        G2[v].push_back({u,w});
        G2[u].push_back({v,w});
    }
}

```

1. لیست همسایه های هر راس
2. لیست همسایه ها برای هر راس که عضو اول همسایه و عضو دوم وزن یال را میگوید!
3. گراف n راس و m یال دارد که دو سر و وزن را ورودی میدهد
### روش دوم :‌ جدول n در n !
ما برای هر دو راس v و u نگه میداریم که ایا این دو راس به یکدیگر یال دارند یا خیر 

e[v][u] = 1 if (v -> u) 

else e[v][u] = 0 

### روش سوم 
هر یال را درون وکتور نگه داری میکنیم
```cpp linenums="1"

int main(){
    int n , m ;
    cin >> n >> m ;
    vector <pair<int,int> > edge ;
    for(int i =1 ; i<= m ; i++){
        int v,  u ;
        cin >> v >> u;
        edge.pb({v,u});
    }
}

```
# dfs

## توضیحات 
جست‌و‌جوی عمق‌اول که به $DFS$
(DepthFirstSearch) معروف است در واقع الگوریتمی برای پیمایش گراف است. شاید با کمی شک بتوان گفت که پرکاربرد‌ترین الگوریتم در گراف همین الگوریتم است چراکه هم کد آن کم است، هم هزینه زمانی و حافظه‌ای آن کم است، هم برای اکثر سوال‌های گراف نیاز به پیمایش است.
## الگورتیم
الگوریتم به این شکل است که ابتدا یک رأس مانند $v$ را انتخاب می‌کنیم و آن را ریشه می‌نامیم. ریشه را علامت‌گذاری می‌کنیم. سپس یک رأس دل خواه علامت نخورده‌ی مجاور با $v$
 را انتخاب می‌کنیم و آن را $u$
 می‌نامیم. $u$
 را یکی از بچه‌های $v$
 می‌کنیم، سپس $u$
 را علامت می‌زنیم. حال همین الگوریتم را روی $u$
 از ابتدا اجرا می‌کنیم (یعنی یکی از همسایه‌های مجاور و علامت نخورده $u$
 را انتخاب می‌کنیم و …).

الگوریتم گفته شده زمانی به بن‌بست می‌خورد که به ازای راسی مانند $u$
، تمام همسایه‌هایش علامت خورده باشند. در این صورت به راس پدر (رأسی که از آن وارد $u$
 شدیم) بر‌می‌گردیم و دوباره همین الگوریتم را از ادامه اجرا می‌کنیم (یعنی وارد پدر $u$
 می‌شویم و اگر همسایه‌ی علامت نخورده‌ای داشت وارد آن می‌شویم و اگر نداشت به رأس پدرش باز می‌گردیم).
برنامه زمانی متوقف میشود که به رأس $v$
 برگشته باشیم و تمام همسایه‌هایش علامت خورده باشند که در این صورت می‌گوییم الگوریتم پایان یافته است. دقت کنید که اگر گراف شما همبند نباشد، این جست‌و‌جو تنها رأس‌های مؤلفه ریشه را پیمایش می‌کند پس اگر برای پیمایش روی تمام رأس‌ها این الگوریتم را به ازای هر رأس علامت‌نخورده‌ای تکرار می‌کنیم.
 

 جست‌و‌جوی اول‌عمق به تنهایی کاربرد خاصی ندارد و در نتیجه محاسباتی که در کنار آن انجام میشود باعث اهمیت آن میشود. به طور کلی این محاسبات را میتوان به دو دسته پس‌ترتیب و پیش‌ترتیب تقسیم کرد. محاسبات پیش‌ترتیب برای هر رأسی هنگام اولین ورود به آن و محاسبات پس‌ترتیب هنگام آخرین خروج از آن انجام میشود.

<figure markdown>
  ![dfs](https://opedia.ir/_media/%D8%A2%D9%85%D9%88%D8%B2%D8%B4/%D8%A7%D9%84%DA%AF%D9%88%D8%B1%DB%8C%D8%AA%D9%85/dfs-all_in_one_path.jpg?w=200&tok=782f39)
  <figcaption> الگورتیم dfs</figcaption>
</figure>

### ویژگی ها
جست‌وجوی اول‌عمق یال‌هایی که تشکیل دور می‌دهند را نمی‌رود (‌منظور یال هایی است که continue میکنیم )‌؛ در نتیجه اگر یال‌های رفته شده را کنار هم بگذاریم، تشکیل یک درخت ریشه‌دار می‌دهند که به آن درخت جست‌و‌جوی اول‌عمق می‌گویند. همچنین زمان ورود و خروج رأس‌ها نیز ویژگی‌های منحصر به فردی دارد. مجموع این ویژگی‌هاباعث شده که این الگوریتم تبدیل به الگوریتمی مهم و کاربردی شود.
### تعریف زیر درخت
درخت ریشه دار dfs را در نظر بگیرید فرض کنید راس 1 راس ریشه این درخت باشد 
راس u درون زیردرخت v است اگر و تنها اگر هر مسیری از u به ریشه (‌یا همان راس 1) از راس v بگذرد.
بعنوان مثال در شکل زیر راس 5 در زیردرخت راس 2 میباشد اما راس 3 در زیردرخت راس 2 نمیباشد زیرا مسیر 3 - 1 وجود دارد 
( هر راس درون زیردرخت خود نیز قرار دارد.)
<figure markdown>
  ![dfs2](https://he-s3.s3.amazonaws.com/media/uploads/9fa1119.jpg)
  <figcaption></figcaption>
</figure>
##کد dfs

```cpp linenums="1"

vector <int> G[maxn] ; //‌ (1)!
int mark[maxn] ; // (2)!

void dfs(int v){
    mark[v] = 1 ;// (3)! 
    for(int u : G[v]){
        if(mark[u] == 1)continue ; // (4)!
        dfs(u) ; // (5)!
    }
}

```

1. همسایه راس $v$ داخل وکتور $G[v]$ قرار دارد ( کافی است هنگام ورودی گرفتن یال ها وکتور ها را اپدیت کنیم )
2. در ابتدا مارک تمامی راس ها ۰ هستند و هر راس را که مشاهده میکنیم مارک ان راس را ۱ میکنیم 
3. راس $v$ را مارک میکنیم
4. همسایه هایی که قبلا مشاهده شدند را وارد نخواهیم شد
5. وارد راس مشاهده نشده میشویم !
### تحلیل اردر dfs
ما هر راس $v$ را حداکثر یک بار وارد خواهیم شد و بر روی تعداد همسایه هاش هزینه خواهیم داد پس هر یال تنها در دو سر $dfs$ ان دیده خواهد شد پس در مجموع n + 2*m خواهد بود که از اردر $O(n+m)$

## مسئله ۱ : مولفه همبندی 
به شما یک گراف با n راس و m یال ورودی داده میشود. تعداد مولفه های همبندی این گراف را چاپ کنید.( مولفه همبندی دسته ماکسیمالی از راس ها هستند که از هر راس v به هر راس u با گذشتن از تعدادی یال میتوان رسید )
الگوریتمی از $O(n+m)$ میخواهیم.
## راه حل
وقتی ما الگوریتم dfs را به ازای راس $v$ اجرا میکنیم تمامی راس های درون مولفه همبندی $v$ مارک ان ها یک خواهد شد .
پس کافی است راس ها را به ترتیب ببینیم اگر تا حالا دیده نشده باشد $dfs$ از ان راس زده و سپس تعداد مولفه ها را یکی زیاد کنیم 
```cpp linenums="1"

int main(){
    int n , m ;
    cin >> n >> m ;
    for(int i = 1; i <= m ; i++){
        int  v, u;
        cin >> v >> u ;
        G[v].push_back(u) ;
        G[u].push_back(v) ; 
    }
    int number_of_components = 0 ;
    for(int i = 1; i <= n ; i++){
        if(mark[i] == 1)continue ;
        dfs(i) ;
        number_of_components ++ ;
    }
    cout << number_of_components << "\n" ;
}

```

## مسئله ۲ : چک کردن دو بخشی
به شما گراف با n راس و m یال داده میشود چک کنید گراف ورودی شده دوبخشی است یا خیر (‌یعنی راس ها را به دو دسته تقسیم کرده به طوری که تمامی یال ها بین دو دسته باشند)‌ 
الگوریتمی از $O(n+m)$ میخواهیم.
## راه حل  
یک درخت را در نظر بگیرید دو بخشی این درخت به طور یکتا مشخص میشود ( درخت همبند است)‌ ان هایی که فاصله زوج از یک راس مشخص دارند ( فاصله تعداد یال های بین دو راس در مسیر یکتا درخت است )‌ یک رنگ با ان راس هستند و فرد ها در دسته دیگر ( زیرا اگر فرض کنیم یک راس درون دسته یک است همسایه های ان در دسته دو و همسایه های همسایه ان راس در دسته یک ... )پس کافی هست برای هر مولفه همبندی زیر درخت را به دست اورده و سپس برای هر یال که درون درخت نیامده چک میکنیم که یال بین دو دسته باشد (‌زیرا در گراف دو بخشی ما میخواهیم راس ها رو دو دسته کنیم به طوری که تمام یال های بین این دو دسته باشد )‌ 
```cpp linenums="1"
vector <int> G[maxn] ;
int r[maxn] ;//(1)!
int mark[maxn] , ch =0 ;
void dfs(int v){
    mark[v]  = 1;
    for(int u : G[v]){
        if(mark[u] == 1){
            if(r[u]==r[v]){
                ch = 1; 
            }
            continue ;
        }
        r[u] = r[v] ^ 1 ; //(2)!
        dfs(u) ; 
    }
}

int main(){
    int n , m ;
    cin >> n >> m ;
    for(int i = 1; i <= m ; i++){
        int  v, u;
        cin >> v >> u ;
        G[v].push_back(u) ;
        G[u].push_back(v) ; 
    }
    for(int i = 1; i <= n ; i++){
        if(mark[i] == 1)continue ;
        dfs(i) ; 
    }
    if(ch==1){
        cout << "do bakhshi nist :( \n" ;
    }else{
        cout << "hast :) \n" ; 
    }
}

```

1. رنگ هر راس در ان نگه داری میشود که عددی بین ۰ و ۱ است که دسته ان را مشخص میکند
2. دسته دو راس مجاور در دسته مخالف هم دیگه است زیرا به همدیگر یال دارند

## استارتینگ تایم و فینیش تایم
در طول پیمایش گراف، رأس‌ها را به طور خاصی رنگ می‌کنیم. در ابتدای کار همه ی **رأس‌ها را سفید** می‌گیریم. حال اولین زمانی که وارد هر رأس شدیم آن را **خاکستری می‌کنیم** و وارد رأس‌های همسایه‌اش می‌شویم. بدین ترتیب رأس خاکستری یعنی رأسی که هنوز کار آن تمام نشده و منتظر است تا کار بچه‌هایش تمام شود اما رأس سفید یعنی رأسی که هنوز ملاقات نشده است. حال هنگامی که تمام همسایه‌های یک رأس دیده شده بودند و در حال بازگشت به رأس پدر بودیم، آن راس را **سیاه می‌کنیم.** در نتیجه هر رأسی که کارش تمام شود، سیاه می‌شود پس در آخر کار همه‌ راس ها سیاه هستند.زمان ورود یا شروع (starting time) و خروج یا پایان (finishingtime) را به ترتیب این‌گونه تعریف می‌کنند: اولین زمان دیده شدن رأس و آخرین زمان دیده شدن رأس. یعنی زمانی که برای اولین بار وارد یک راس می‌شویم و آن را علامت گذاری می‌کنیم را زمان ورود و آخرین زمانی که از رأس خارج می‌شویم و تمام همسایه‌هایش دیده شده است و در حال بازگشت به راس پدر هستیم را زمان خروج می‌گیریم. پس اگر بخواهیم با رنگ‌ها این دو زمان را معادل کنیم، زمان خاکستری شدن برابر زمان شروع و زمان سیاه شدن برابر زمان خروج است.

در زیر سه لم در مورد این زمان‌ها آورده‌ایم که اثبات دو لم اول راحت است و لم سوم نیز با استفاده از این دولم ثابت می‌شود.

لم ۱: زمان شروع رأس v کمتر از u
 است اگر و تنها اگر v
 جد u
 باشد یا در درخت ریشه‌دار قبل از u
 آمده باشد.(یعنی سیاه شده باشد قبل از ورود به v)
 
لم۲: زمان خاتمه رأس v
 کمتر از u
 است اگر و تنها اگر u
 جد v
 باشد یا در درخت ریشه‌دار قبل از u
 آمده باشد.(یعنی سیاه شده باشد قبل از ورود به v)
 
لم۳: اگر زمان شروع رأس v
 کمتر از u
 و زمان پایان رأس u
 کمتر از v
 باشد، آنگاه v
 جد u
 است.
 
 اگر لم ۱ و لم ۲ رو قبول کنیم لم ۳ درست است زیرا اگر $v$ جد $u$ نباشد طبق لم ۱ یعنی $v$ قبل از ورود به  $u$ سیاه شده است و طبق لم ۲ یعنی $u$ قبل از ورود به $v$ سیاه شده است که این دو حرف امکان ندارد همزمان رخ دهد پس قطعا v جد u میشود.
 
در نتیجه خاصیت خوبی که این درخت و این الگوریتم به ما می‌دهد این است که می‌توانیم فرض کنیم هنگامی که از یک رأس خارج می‌شویم، کار تمام زیر درخت آن تمام شده است. در نتیجه با توجه به جواب بچه‌های این رأس، جواب این راس را محاسبه می‌کنیم. برای همین معمولا در صورت نیاز به برنامه‌ریزی پویا روی گراف از جست‌و‌جوی عمق‌اول استفاده می‌کنند.
!!! danger "مهم"
       در واقع به زبان دیگر ما در تمام زمانی که یک راس خاکستری است ما در DFS در راس های زیر درخت ان راس بوده ایم.

که اینگونه اثبات واضح تر میشود . درصورتی که بازه زمانی یک راس تماما داخل بازه زمانی راس دیگر باشد انگاه ان راس از نوادگان راس دیگر میباشد.
```cpp linenums="1"
vector <int> G[maxn] ;
int mark[maxn] , time =0 , st[maxn] , en[maxn] ;//(1)!
void dfs(int v){
    time ++ ;
    st[v] = time ; 
    mark[v]  = 1;
    for(int u : G[v]){
        if(mark[u] == 1)continue ;
        dfs(u) ; 
    }
    time++ ;
    en[v] = time ;
}
```

1. استارتینگ تایم و فینیش تایم به ترتیب $st[v]$ و $en[v]$ میباشد.



### مسئله 1 : v جد u است ؟
درخت n
 راسی به همراه q
 کوئری به ما داده شده. در هر کوئری باید چک کنیم ایا راس u
 جد راس v
 است یا نه. $O(n+q)$
### راه حل 
همان گونه که بالا تر گفتیم تنها کافی است دو شرط زیر برقرار باشد :

$( st[v] <= st[u] و en[u] <= en[v] )$


زیرا در بازه زمانی ای که راس v خاکستری است ما درون زیردرخت v میباشیم پس u باید در ان بازه دیده شده باشد.
```cpp linenums="1"
bool ch(int v , int u){//(1)!
    if(st[v] <= st[u] && en[u] <= en[v]){
        return 1;
    }
    return 0 ;
}
```

1. اگر v جد u باشد 1 برمیگرداند در غیر اینصورت 0

پس هر پرسش را o(1) برمیگردانیم و dfs برای پیدا کردن استارتینگ تایم و فینیش تایم که درمجموع o(n+q) میشود

### مسئله 2 : پیدا کردن k امین جد !
درخت n
 راسی به همراه q
 کوئری به ما داده شده. در هر کوئری باید k
 امین پدر راس v
 را پیدا کنیم.$O(n+q.log(n))$
### راه حل 
تمام ریوس با ارتفاع $h[v]−k$
 را در نظر بگیرید. با استفاده از لم سوال قبل میتوان نتیجه گرفت جواب راس با بیشترین استارتینگ تایم کمتر از استارتینگ تایم راس v
 در بین ریوس در ارتفاع k
 تا بالاتر است. به بیان دیگر

u with maximum startingtime such that
$(h[u] = h[v] - k) and (st[u] <= st[v])$


به ازای هر ارتفاع یک وکتور از تمام ریوس ان ارتفاع بسازید که ریوس هر وکتور بر حسب استارتینگ تایم مرتب شده اند. O(n)

حال هر کوئری سوال به یک باینری سرچ روی یکی از این وکتور ها تبدیل میشود!


## انواع یال
درخت جست‌و‌جوی عمق‌اول در واقع یک درخت ریشه‌دار است که ریشه آن همان رأسی است که جست‌و‌جو از آن آغاز شده است. این درخت شامل تمام یال‌هایی است که الگوریتم روی آن‌ها حرکت کرده و و پدر هر راسی، راسی است که از آن وارد این راس شده‌ایم. پس واضح است که برخی از یال‌ها در درخت نمی‌آیند و همچنین این درخت ریشه‌دار دور ندارد چون هر رأسی تنها یک پدر دارد! به طور کلی یال‌های گراف اصلی را میتوان به ۴ دسته تقسیم کرد:

1. یال‌‌های درخت ساخته شده (یال درختی یاTree Edge)
2. از یک راس به جدش (یال عقب‌رو یا Back Edge)
3. از یک راس به زیر درختش (یال جلو‌رو یا Forward Edge)
4. هیچ کدام از سه مورد بالا (یال میانی یا Corss Edge)
در گراف‌های بدون‌جهت دسته دو و سه یکی هستند زیرا یال‌ها جهتی ندارند و یک یال جلورو حتما یک یال عقب‌رو است و برعکس. 
<figure markdown>
  ![dfs3](https://opedia.ir/_media/%D8%A2%D9%85%D9%88%D8%B2%D8%B4/%D8%A7%D9%84%DA%AF%D9%88%D8%B1%DB%8C%D8%AA%D9%85/270px-tree_edges.svg.png?w=300&tok=ca39b1)
  <figcaption></figcaption>
</figure>


### ادعا 
اگر ما درخت جست و جوی عمق اول (‌در گراف بی جهت )‌را در نظر بگیریم یال از نوع **4** یا **‌کراس ادج**‌ نخواهیم داشت.

### اثبات 
فرض کنید یال کراس ادج بین دو راس $v$ و $u$ باشد. بین این دو راس , راسی که starting time کمتری دارد در نظر بگیرید فرض کنید راس $v$ باشد پس در اول راس $v$ خاکستری شده و تا قبل این که ان راس سیاه شود باید راس $u$ خاکستری شود زیرا راس $v$ قبل سیاه شدن میتواند وارد u شود زیرا همسایه هستند پس u قبل سیاه شدن و بعد خاکستری شدن راس $v$ خاکستری میشود و ما قبلا گفتیم که  
"**‌در واقع به زبان دیگر ما در تمام زمانی که یک راس خاکستری است ما درون زیر درخت ان راس خواهیم بود** "
پس درون زیر درخت $v$ خواهد بود پس بک ادج خواهد بود نه کراس ادج 

این لم مهم است زیرا بعضی اوقات برای حل سوالات از این لم کمک میگیریم.
#  قطر درخت 
به بلند ترین مسیر درخت قطر گفته میشود (‌به طور کلی فاصله به معنای تعداد یال های مسیر بین دو راس گفته میشود).
## پیدا کردن قطر درخت
طول بلند ترین مسیر در درخت را چاپ کنید و دو راسی که این طول بین انها است را بگویید (‌اگر یکتا نبود هر کدام را چاپ کنید قبول است)‌
الگوریتمی از $o(n)$
###راه حل :
هر دو راه حل سوال به طور کامل در کتاب گراف شاززز قرار دارد 

 لینک راه : https://gtoi.shaazzz.ir/book/2/6.html

# تعریف یال برشی و راس برشی
یال برشی : به یالی گفته میشود که اگر ما یال را از گراف حذف کنیم تعداد مولفه های همبندی گراف افزایش یابد .
راس برشی  :‌به راسی گفته میشود که اگر ما راس را از گراف حذف کنیم تعداد مولفه همبندی افزایش یابد.

## مسئله 1 : پیدا کردن یال برشی ها
گراف n راسی و m یالی ورودی داده میشود یال هایی که برشی هستند را چاپ کنید. ( O(n+m) )
گراف ممکن است یال چند گانه داشته باشد.

### راه حل :‌
بیاید از الگوریتم dfs  کمک بگیریم . در ابتدا میگوییم که هر یالی که در درخت dfs نیاید برشی نیست زیرا در صورت حذف یال های بیرون درخت dfs ما همچنان درخت dfs را داشته و این یال ها باعث میشوند که گراف همبند بماند . 

پس ما کافی است برای یال های  درخت dfs بگوییم که برشی هستند یا خیر .

هر یال درخت را اگر حذف کنیم درخت dfs  به دو تیکه زیر درخت یال و بقیه درخت تقسیم میشود که باید ببینیم یالی از بقیه گراف وجود دارد که این دو دسته (‌زیردرخت یال و بقیه راس ها )‌را به هم متصل کند یا خیر.

بیاید d[v] را بالا ترین یالی بگیریم که یک سر ان در زیردرخت راس v باشد ( بین هر یالی که یک سر ان درون زیر درخت باشد و سر دیگر بیرون زیر درخت , کمترین ارتفاع سر یالی که بیرون زیر درخت است نگه داشته میشود )‌ و جزو درخت dfs نباشد.

 **‌دقت کنید که ما از شرایط بقیه یال ها در dfs استفاده میکنیم (‌لمی که در ان اثبات کردیم که هر یال به صورت یالی از جد به بچه میباشد)**


 ادعا میکنیم یال برشی است اگر و تنها اگر $d[v] >= dis[v]$ زیرا اگر d[v] بیشتر مساوی ارتفاع راس باشد انگاه بین دو مولفه زیر و بالا یال هیچ یالی متصل نمیکند ( زیرا هر یال بین که یک سر ان در زیر درخت v است یا درون زیر درخت v میباشد یا طبق لمی که قبلا اثبات کردیم به جد های v متصل است که اگر به یکی از جد های v متصل باشد ارتفاع ان کمتر از ارتفاع v میباشد) 
 
 
 در غیر اینصورت ان یالی که d[v] را کمتر از dis[v] کرده است ان یال یک سر ان بالا تر است و سر دیگر بالای زیردرخت میباشد
 

 
**ارتفاع راس v در درخت = dis[v]**

 
 ارتفاع راس ها را به سادگی میتوان محاسبه کرد و d[v] نیز برابر با مینیمم هر که یال به v متصل است و d[u] به طوری که u از  فرزندان v باشد (‌هر یال یا سر ان v است یا درون ساب تری یکی از فرزندان v قرار دارد.)‌
 
دقت کنید که ما باید یال های درخت را در d[v] نظر نمیگیریم (‌زیرا یال به پدر هر راس v ارتفاع dis[v] - 1 دارد)‌ ولی ممکن است چند یال بین این دو راس وجود داشته باشد پس کافی است ما فقط یک بار وارد ان نشویم.  و d[v] را از یال به پدر خود اپدیت نکنیم)
 
```cpp linenums="1"
vector <int> G[maxn] ;
int mark[maxn] , dis[maxn] , d[maxn] ; 

void dfs(int v  ,int p ){//(2)!
    mark[v] = 1; 
    bool ok = 0 ; // (1)!
    d[v] = dis[v] ; 
    for(int u : G[v]){
        if(mark[u] == 1){
            if(u == p && ok == 0){
                ok = 1;
                continue ; 
            }
            d[v] = min(d[v] , dis[u]) ;
            continue ;
        }
        dis[u] = dis[v]+1 ; 
        dfs(u,v) ; 
        d[v] = min(d[v] , d[u]) ;
    }
    if(d[v] >= dis[v] && p != -1){
        cout << p << " "<< v << " yal boreshie\n" ; 
    }
}
int  main(){
    int n ,  m;cin >> n >> m ;
    for(int i = 1; i <= m ; i++){
        int v, u ;
        cin >> v >> u  ;
        G[v].pb(u);
        G[u].pb(v) ;
    }
    for(int i = 1 ;i <= n; i++){
        if(mark[i] == 1)continue ;
        dfs(i,-1);
    }
}
```

1. یال بین v و جد خود را دیده ایم یا خیر(چون فقط دفعه اول d[v] را نباید اپدیت کند.) برای راس ریشه p را برابر با -1 قرار دهید
2. راس p در واقع راس پدر v میباشد.


## مسئله 2 : پیدا کردن راس برشی ها

بیاید مانند بالا dfs بزنیم و هر فاصله راس ها و d[v] را محاسبه کنیم

ادعا میکنیم که راس ریشه راس برشی میباشد اگر و تنها اگر که در درخت dfs بیشتر از یک بچه داشته باشد.
زیرا یک بچه یا کمتر داشته باشد با حذف این راس یال های dfs گراف را همبند نگه میدارند و اگر حداقل دو بچه داشته باشد ما میدانیم که بین زیر درخت بچه های راس ریشه یالی وجود ندارد (‌زیرا هر یالی که در درخت dfs نیست به صورت یالی از جد به بچه میباشد) پس بعد از حذف زیردرخت بچه های ریشه مولفه همبندی جدایی خواهند داشت 

حال بیاید برای راس های دیگر بجز ریشه ببینیم در چه صورت برشی خواهند بود (‌در واقع ریشه حالت خاصی بود که ما باید چک کنیم)‌
بیاید درخت dfs را در نظر بگیرید بعد از حذف راس v ما به اندازه درجه ان راس مولفه همبندی خواهیم داشت(‌زیردرخت بجه های راس v و بقیه گراف بجز زیردرخت  راس v)‌ و مجددا ما میدانیم که هر یال که در درخت نیست به صورت جد به بچه های ان جد میباشد پس هر کدام از زیردرخت های بچه های راس v باید بقیه گراف به جز ساب تری متصل شوند زیرا هیج یالی بین زیر درخت بچه های راس v وجود ندارد. پس اگر یکی از بچه های راس v هیج یالی بالا تر از v نداشته باشد پس از حذف v ان راس مولفه همبندی جدا خواهد شد پس ما کافی است تنها به ازای هر u که بچه v است که 

$d[u] >= dis[v]$

اگر این شرط برقرار باشد زیردرخت u بعد از حذف v مولفه جدا خواهد شد.
```cpp linenums="1"
int mark[maxn] , dis[maxn] , d[maxn] ; 
void dfs(int v  ,int p ){
    mark[v] = 1;
    int ted = 0 , ch =0 ; 
    d[v] = dis[v] ; 
    for(int u : G[v]){
        if(mark[u] == 1){
            d[v] = min(d[v] , dis[u]) ;
            continue ;
        }
        dis[u] = dis[v]+1 ; 
        dfs(u,v) ; 
        d[v] = min(d[v] , d[u]) ;
        if(d[u] >= dis[v]){
            ch = 1 ; 
        }
        ted++ ;
    }
    if(p == -1 && ted > 1){// (1)!
        cout << v << " " ;
    }
    if(p!=-1 && ch == 1){//(2)!
        cout << v  << " " ;
    }
}
int  main(){
    int n ,  m;cin >> n >> m ;
    for(int i = 1 ; i <= m ; i++){
        int v, u ;
        cin >> v >> u  ;
        G[v].pb(u);
        G[u].pb(v) ;
    }
    for(int i = 1; i <= n ; i++){
        if(mark[i] == 1)continue ;
        dfs(i,-1);
    }
}
```

1. حالت ریشه : باید راس های درخت dfs کمتر مساوی ۱ باشد.
2. بقیه راس ها به جز ریشه :‌ هر زیر درخت باید حداقل یک یال به بالا راس v داشته باشد در غیر اینصورت ch یک میشود.

 
 

# سوال ها 
??? warning "حاوی سوالات المپیاد کامپیوتر ایران!"
    سوالات المپیادی از دوره های سابق المپیاد کامپیوتر ایران است، توصیه میشود اگر میخواهید این آزمون ها را در آینده بدهید آنها را باز نکنید!
 <form name="cf-handel-form" class="cf-handel-form" onsubmit="return cf_status_checker()">
  <input type="text" id="cf-handel" name="cf-handel" class="handel-input" placeholder="هندل کدفرسز:"><br>
  <input type="submit" value="Submit" class="md-button cf-handel-button">
</form> | سوال | سختی | تگ ها | جاج | 
| :-----: | :----: | :----: | :----: | 
|[Ice Skating](https://codeforces.com/problemset/problem/217/A){:target="_blank"}|1200|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Graph Without Long Directed Paths](https://codeforces.com/contest/1144/problem/F){:target="_blank"}|1800|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Subtree K-th Max](https://atcoder.jp/contests/abc239/tasks/abc239_e){:target="_blank"}|1900|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-atcoder: [Atcoder](https://atcoder.jp){:target="_blank"}|
|[Vasya and a tree](https://codeforces.com/contest/1076/problem/E){:target="_blank"}|1900|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[MinOr Tree](https://codeforces.com/contest/1624/problem/G){:target="_blank"}|1900|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Chemical table](https://codeforces.com/problemset/problem/1012/B){:target="_blank"}|1900|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Book of Evil](https://codeforces.com/contest/337/problem/d){:target="_blank"}|2000|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Ant on the Tree](https://codeforces.com/problemset/problem/29/D?locale=en){:target="_blank"}|2000|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Number of Simple Paths](https://codeforces.com/contest/1454/problem/E){:target="_blank"}|2000|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Computer Network](https://codeforces.com/problemsets/acmsguru/problem/99999/149){:target="_blank"}|2000|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [SGU](https://codeforces.com/problemsets/acmsguru){:target="_blank"}|
|[Wormhole Sort](http://www.usaco.org/index.php?page=viewproblem2&cpid=992v){:target="_blank"}|2000|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-usaco: [Usaco](https://usaco.org){:target="_blank"}|
|[Where's Bessie?](http://www.usaco.org/index.php?page=viewproblem2&cpid=740){:target="_blank"}|2000|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-usaco: [Usaco](https://usaco.org){:target="_blank"}|
|[Minimal Diameter Forest](https://codeforces.com/contest/1092/problem/E){:target="_blank"}|2000|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Milk Visits](http://www.usaco.org/index.php?page=viewproblem2&cpid=968){:target="_blank"}|2000|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-usaco: [Usaco](https://usaco.org){:target="_blank"}|
|[Construct Highway](https://atcoder.jp/contests/abc239/tasks/abc239_f){:target="_blank"}|2100|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-atcoder: [Atcoder](https://atcoder.jp){:target="_blank"}|
|[Mahmoud and a xor trip](https://codeforces.com/problemset/problem/766/E){:target="_blank"}|2100|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Blood Cousins](https://codeforces.com/problemset/problem/208/E){:target="_blank"}|2100|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Leha and another game about graph](https://codeforces.com/contest/841/problem/D){:target="_blank"}|2100|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Bertown roads](https://codeforces.com/contest/118/problem/E){:target="_blank"}|2100|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Graph](https://codeforces.com/contest/1387/problem/A){:target="_blank"}|2100|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Little Pony and Summer Sun Celebration](https://codeforces.com/problemset/problem/453/C){:target="_blank"}|2200|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Super M](https://codeforces.com/contest/592/problem/d){:target="_blank"}|2200|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Cycling Coloring](https://codeforces.com/problemset/problem/183/C){:target="_blank"}|2200|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|<div class="blur-spoiler">[کپی پیست](https://quera.org/problemset/3017/){:target="_blank"}</div>|2200|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-quera: [المپیادی](https://codeforces.org){:target="_blank"}|
|[Wizard's Tour](https://codeforces.com/problemset/problem/858/F){:target="_blank"}|2300|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Graph Cutting](https://codeforces.com/contest/405/problem/E){:target="_blank"}|2300|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Pursuit for artifacts](https://codeforces.com/contest/652/problem/E){:target="_blank"}|2300|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Blood Cousins Return](https://codeforces.com/problemset/problem/246/E){:target="_blank"}|2400|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Challenging Tic-Tac-Toe](https://codeforces.com/problemsets/acmsguru/problem/99999/289){:target="_blank"}|2400|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [SGU](https://codeforces.com/problemsets/acmsguru){:target="_blank"}|
|[Road Problem](https://codeforces.com/contest/45/problem/h){:target="_blank"}|2400|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Guard Towers](https://codeforces.com/problemset/problem/85/E){:target="_blank"}|2600|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Johnny Solving](https://codeforces.com/problemset/problem/1103/C){:target="_blank"}|2700|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Fairy](https://codeforces.com/contest/19/problem/E){:target="_blank"}|2700|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[Prison](https://oj.uz/problem/view/BOI21_prison){:target="_blank"}|2700|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li> <li>dsu</li></ul> </details>|:judge-ojuz: [Oj.uz](https://oj.uz){:target="_blank"}|
|[AquaMoon and Permutations](https://codeforces.com/contest/1545/problem/C){:target="_blank"}|2800|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-codeforces: [Codeforces](https://codeforces.com/){:target="_blank"}|
|[T-covering](https://oj.uz/problem/view/eJOI19_covering){:target="_blank"}|2900|<details> <summary>Spoiler</summary> <ul><li>[dfs](/Level2/dfs){:target="_blank"}</li></ul> </details>|:judge-ojuz: [Oj.uz](https://oj.uz){:target="_blank"}|
