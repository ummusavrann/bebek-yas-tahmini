# Bebek Yaşı Tahmini – Makine Öğrenmesi Projesi

## 📌 Proje Amacı

Bu projede 2023 yılına ait yaklaşık 925.000 gözlem içeren satış verisi kullanılarak bebek yaşı (gün cinsinden) tahmin edilmiştir.

Çalışmada farklı regresyon modelleri karşılaştırılmış ve en düşük hata değerini üreten model belirlenmiştir.

⚠️ Veri ticari gizlilik nedeniyle paylaşılmamıştır.

---

## 📊 İş Problemi

0–4 yaş aralığında faaliyet gösteren bir firma için bebek yaşının doğru tahmin edilmesi:

- Kişiye özel kampanya planlaması
- Tavsiye sistemlerinin iyileştirilmesi
- Stok yönetiminin optimize edilmesi
- Ürün geliştirme stratejilerinin desteklenmesi

açısından kritik öneme sahiptir.

---

## 🧠 Kullanılan Regresyon Modelleri

- Linear Regression
- 4. Dereceden Polynomial Regression
- Decision Tree Regressor
- Random Forest Regressor
- K-Nearest Neighbors (KNN)
- XGBoost Regressor

---

## 📈 Model Değerlendirme

Modellerin performansı Root Mean Squared Error (RMSE) metriği ile değerlendirilmiştir.

Sonuçlar, XGBoost modelinin diğer modellere kıyasla daha düşük RMSE ürettiğini göstermiştir.

---

## ⚙️ Teknik Süreç

- Veri ön işleme (R)
- Feature engineering
- Kategorik değişken düzenleme
- Python ile model geliştirme
- Model performans karşılaştırması
- Müşteri bazlı gruplanmış tahmin analizi

---

## 🛠 Kullanılan Teknolojiler

- Python (scikit-learn, XGBoost, pandas, numpy)
- R
- Makine Öğrenmesi
- Regresyon Analizi

## 📊 Model Performans Karşılaştırması

![Model Performance](results/model_performance.png)
