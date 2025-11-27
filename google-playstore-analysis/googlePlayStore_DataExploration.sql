-- Statistik Deskriptif untuk Kolom Numerik
-- Menghitung rata-rata, nilai minimum, maksimum, dan standar deviasi dari kolom numerik seperti Rating, Reviews, Size, Installs, dan Price
SELECT 
    AVG(Rating) AS avg_rating,     -- Rata-rata Rating aplikasi
    MIN(Rating) AS min_rating,     -- Rating terendah
    MAX(Rating) AS max_rating,     -- Rating tertinggi
    STDDEV(Rating) AS stddev_rating, -- Standar deviasi Rating
    AVG(Reviews) AS avg_reviews,   -- Rata-rata jumlah Reviews
    MIN(Reviews) AS min_reviews,   -- Jumlah Reviews terendah
    MAX(Reviews) AS max_reviews,   -- Jumlah Reviews tertinggi
    AVG(Size) AS avg_size,         -- Rata-rata ukuran aplikasi
    MIN(Size) AS min_size,         -- Ukuran aplikasi terkecil
    MAX(Size) AS max_size,         -- Ukuran aplikasi terbesar
    AVG(Installs) AS avg_installs, -- Rata-rata jumlah Instalasi
    MIN(Installs) AS min_installs, -- Instalasi terkecil
    MAX(Installs) AS max_installs, -- Instalasi terbanyak
    AVG(Price) AS avg_price        -- Rata-rata harga aplikasi
FROM googleplaystore;

-- Distribusi Rating
-- Menghitung jumlah aplikasi untuk setiap rating yang ada
SELECT 
    Rating, 
    COUNT(*) AS count
FROM googleplaystore
GROUP BY Rating
ORDER BY Rating DESC;

-- Size vs Installs
-- Menampilkan Size dan Installs untuk aplikasi yang memiliki kedua kolom tersebut
SELECT 
    DISTINCT Size, 
    Installs
FROM googleplaystore
WHERE Size IS NOT NULL AND Installs IS NOT NULL
ORDER BY Installs DESC;

-- Rata-Rata Rating per Kategori
-- Menghitung rata-rata Rating aplikasi berdasarkan kategori dan mengurutkannya dari yang tertinggi
SELECT 
    Category, 
    AVG(Rating) AS avg_rating
FROM googleplaystore
GROUP BY Category
ORDER BY avg_rating DESC;

-- Aplikasi dengan Instalasi Terbanyak
-- Menampilkan 10 aplikasi dengan jumlah Instalasi terbanyak
SELECT 
    App, 
    Installs
FROM googleplaystore
ORDER BY Installs DESC
LIMIT 10;

-- Rata-Rata Rating dan Instalasi
-- Menghitung rata-rata Rating dan Instalasi dari seluruh aplikasi
SELECT 
    AVG(Rating) AS avg_rating,
    AVG(Installs) AS avg_installs
FROM googleplaystore;
