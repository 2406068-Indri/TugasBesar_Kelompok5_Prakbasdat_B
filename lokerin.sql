CREATE DATABASE IF NOT EXISTS lokerin;
USE lokerin;

-- 1. Tabel Utama Pengguna
CREATE TABLE users (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin','perusahaan','pelamar') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabel Profil Perusahaan
CREATE TABLE perusahaan (
    id_perusahaan INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT NOT NULL,
    nama_perusahaan VARCHAR(100),
    deskripsi TEXT,
    alamat TEXT,
    telepon VARCHAR(20),
    website VARCHAR(100),
    logo VARCHAR(255),
    FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE
);

-- 3. Tabel Profil Pelamar
CREATE TABLE pelamar (
    id_pelamar INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT NOT NULL,
    jenis_kelamin ENUM('L','P'),
    tanggal_lahir DATE,
    alamat TEXT,
    pendidikan VARCHAR(100),
    cv VARCHAR(255),
    FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE
);

-- 4. Tabel Lowongan Kerja
CREATE TABLE lowongan (
    id_lowongan INT AUTO_INCREMENT PRIMARY KEY,
    id_perusahaan INT NOT NULL,
    judul VARCHAR(100) NOT NULL,
    deskripsi TEXT,
    lokasi VARCHAR(100),
    gaji DECIMAL(12,2),
    kuota INT,
    deadline DATE,
    status ENUM('aktif','nonaktif') DEFAULT 'aktif',
    FOREIGN KEY (id_perusahaan) REFERENCES perusahaan(id_perusahaan) ON DELETE CASCADE
);

-- 5. Tabel Transaksi Lamaran
CREATE TABLE lamaran (
    id_lamaran INT AUTO_INCREMENT PRIMARY KEY,
    id_lowongan INT NOT NULL,
    id_pelamar INT NOT NULL,
    tanggal_lamar TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('diproses','diterima','ditolak') DEFAULT 'diproses',
    FOREIGN KEY (id_lowongan) REFERENCES lowongan(id_lowongan) ON DELETE CASCADE,
    FOREIGN KEY (id_pelamar) REFERENCES pelamar(id_pelamar) ON DELETE CASCADE
);

-- INSERT AKUN ADMIN BAWAAN (Password: admin123)
INSERT INTO users (nama, email, password, role) 
VALUES ('Super Admin', 'admin@lokerin.com', '$2y$10$wN10U5mYI3Gj7pSgY.b.IeW1fXmAGI2.oV0pBf1K53a0p92m1W8m2', 'admin');