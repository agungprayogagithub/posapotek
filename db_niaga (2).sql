-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 16 Bulan Mei 2024 pada 05.45
-- Versi server: 10.1.38-MariaDB
-- Versi PHP: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_niaga`
--

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `qw_barang`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `qw_barang` (
`kd_barang` varchar(9)
,`nama_barang` varchar(50)
,`id_jenis` int(11)
,`satuan` varchar(25)
,`stok` int(11)
,`harga_pokok` int(11)
,`ppn` int(11)
,`harga_jual` int(11)
,`jenis` varchar(25)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `qw_barang_masuk`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `qw_barang_masuk` (
`kd_barang_masuk` varchar(11)
,`kd_supplier` varchar(6)
,`kd_barang` varchar(9)
,`nama_barang` varchar(50)
,`satuan` varchar(25)
,`harga` int(11)
,`jumlah` int(11)
,`total_harga` int(11)
,`tanggal` date
,`nama_supplier` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `qw_transaksi`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `qw_transaksi` (
`no_transaksi` varchar(11)
,`tgl_transaksi` date
,`waktu` timestamp
,`id_kasir` varchar(20)
,`subtotal` int(11)
,`diskon` int(3)
,`total_akhir` int(11)
,`bayar` int(11)
,`kembalian` int(11)
,`nama_kasir` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `qw_user`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `qw_user` (
`id_user` int(11)
,`nama_user` varchar(50)
,`jk_user` varchar(9)
,`alamat_user` text
,`no_telp_user` varchar(13)
,`username` varchar(20)
,`password` varchar(30)
,`type_user` int(1)
,`jabatan` varchar(7)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_barang`
--

CREATE TABLE `tbl_barang` (
  `kd_barang` varchar(9) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `id_jenis` int(11) NOT NULL,
  `satuan` varchar(25) NOT NULL,
  `stok` int(11) NOT NULL,
  `harga_pokok` int(11) NOT NULL,
  `ppn` int(11) NOT NULL,
  `harga_jual` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_barang`
--

INSERT INTO `tbl_barang` (`kd_barang`, `nama_barang`, `id_jenis`, `satuan`, `stok`, `harga_pokok`, `ppn`, `harga_jual`) VALUES
('BRG000002', 'Sanprima', 1, 'Lempeng', 9, 30000, 0, 30000),
('BRG000003', 'Amoxilin 500 Mg', 1, 'Lempeng', 0, 35000, 0, 35000),
('BRG000004', 'OBH Combi', 28, 'Botol', 0, 25000, 0, 25000),
('BRG000005', 'Siladex', 28, 'Lempeng', 14, 15000, 0, 15000),
('BRG000006', 'Zoralin', 29, 'Lempeng', 0, 20000, 0, 20000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_barang_masuk`
--

CREATE TABLE `tbl_barang_masuk` (
  `kd_barang_masuk` varchar(11) NOT NULL,
  `kd_supplier` varchar(6) NOT NULL,
  `kd_barang` varchar(9) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `satuan` varchar(25) NOT NULL,
  `harga` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `total_harga` int(11) NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_barang_masuk`
--

INSERT INTO `tbl_barang_masuk` (`kd_barang_masuk`, `kd_supplier`, `kd_barang`, `nama_barang`, `satuan`, `harga`, `jumlah`, `total_harga`, `tanggal`) VALUES
('1605BELI001', 's001', 'BRG000002', 'Sanprima', 'Lempeng', 30000, 10, 300000, '2024-05-16'),
('1605BELI002', 's001', 'BRG000005', 'Siladex', 'Lempeng', 15000, 15, 225000, '2024-05-16');

--
-- Trigger `tbl_barang_masuk`
--
DELIMITER $$
CREATE TRIGGER `hapus_barangmasuk` AFTER DELETE ON `tbl_barang_masuk` FOR EACH ROW UPDATE tbl_barang SET stok = stok-OLD.jumlah WHERE kd_barang = OLD.kd_barang
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `hapus_barangmasuk1` BEFORE DELETE ON `tbl_barang_masuk` FOR EACH ROW DELETE FROM tbl_keuangan WHERE id_asal = OLD.kd_barang_masuk
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tambah_barangmasuk` AFTER INSERT ON `tbl_barang_masuk` FOR EACH ROW UPDATE tbl_barang SET stok = stok+NEW.jumlah WHERE kd_barang = NEW.kd_barang
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_barangmasuk` AFTER UPDATE ON `tbl_barang_masuk` FOR EACH ROW UPDATE tbl_barang SET stok = (stok - OLD.jumlah) + NEW.jumlah  WHERE kd_barang = NEW.kd_barang
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_barangmasuk1` BEFORE UPDATE ON `tbl_barang_masuk` FOR EACH ROW UPDATE tbl_keuangan SET keluar = (keluar-OLD.total_harga)+NEW.total_harga WHERE id_asal = NEW.kd_barang_masuk
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_jenis`
--

CREATE TABLE `tbl_jenis` (
  `id_jenis` int(11) NOT NULL,
  `jenis` varchar(25) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_jenis`
--

INSERT INTO `tbl_jenis` (`id_jenis`, `jenis`) VALUES
(1, 'Anti Biotik'),
(29, 'Obat Alergi'),
(28, 'Obat Batuk');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_keuangan`
--

CREATE TABLE `tbl_keuangan` (
  `id_keuangan` int(11) NOT NULL,
  `id_asal` varchar(11) NOT NULL,
  `tanggal` date NOT NULL,
  `waktu` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `jenis_keuangan` varchar(25) NOT NULL,
  `masuk` int(11) NOT NULL,
  `keluar` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_keuangan`
--

INSERT INTO `tbl_keuangan` (`id_keuangan`, `id_asal`, `tanggal`, `waktu`, `jenis_keuangan`, `masuk`, `keluar`) VALUES
(6, '16052024001', '2024-05-16', '2024-05-16 03:36:58', 'Pendapatan Harian', 45000, 0),
(5, '1605BELI002', '2024-05-16', '2024-05-16 03:34:46', 'Pembelian Siladex', 0, 225000),
(4, '1605BELI001', '2024-05-16', '2024-05-16 03:34:33', 'Pembelian Sanprima', 0, 300000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_supplier`
--

CREATE TABLE `tbl_supplier` (
  `kd_supplier` varchar(6) NOT NULL,
  `nama_supplier` varchar(50) NOT NULL,
  `alamat_supplier` text NOT NULL,
  `no_telp_supplier` varchar(13) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_supplier`
--

INSERT INTO `tbl_supplier` (`kd_supplier`, `nama_supplier`, `alamat_supplier`, `no_telp_supplier`) VALUES
('s001', 'PT Kimia Farma', 'Bandar Lampung	\r\n', '085366446553');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_transaksi`
--

CREATE TABLE `tbl_transaksi` (
  `no_transaksi` varchar(11) NOT NULL,
  `tgl_transaksi` date NOT NULL,
  `waktu` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_kasir` varchar(20) NOT NULL,
  `subtotal` int(11) NOT NULL,
  `diskon` int(3) NOT NULL,
  `total_akhir` int(11) NOT NULL,
  `bayar` int(11) NOT NULL,
  `kembalian` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_transaksi`
--

INSERT INTO `tbl_transaksi` (`no_transaksi`, `tgl_transaksi`, `waktu`, `id_kasir`, `subtotal`, `diskon`, `total_akhir`, `bayar`, `kembalian`) VALUES
('16052024001', '2024-05-16', '2024-05-16 03:36:58', 'kasir', 45000, 0, 45000, 45000, 0);

--
-- Trigger `tbl_transaksi`
--
DELIMITER $$
CREATE TRIGGER `hapus_transaksi` AFTER DELETE ON `tbl_transaksi` FOR EACH ROW UPDATE tbl_keuangan SET masuk = masuk-OLD.total_akhir WHERE tanggal = OLD.tgl_transaksi AND jenis_keuangan = 'Pendapatan Harian'
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tambah_transaksi` AFTER INSERT ON `tbl_transaksi` FOR EACH ROW UPDATE tbl_keuangan SET id_asal = NEW.no_transaksi, masuk = masuk+NEW.total_akhir WHERE tanggal = NEW.tgl_transaksi AND jenis_keuangan = 'Pendapatan Harian'
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_transaksi` AFTER UPDATE ON `tbl_transaksi` FOR EACH ROW UPDATE tbl_keuangan SET id_asal = NEW.no_transaksi, masuk = (masuk-OLD.total_akhir)+NEW.total_akhir WHERE tanggal = NEW.tgl_transaksi AND jenis_keuangan = 'Pendapatan Harian'
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_transaksi_detail`
--

CREATE TABLE `tbl_transaksi_detail` (
  `id` int(11) NOT NULL,
  `no_transaksi` varchar(11) NOT NULL,
  `kd_barang` varchar(9) NOT NULL,
  `barang` varchar(50) NOT NULL,
  `harga` int(11) NOT NULL,
  `banyak` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `konsumen` varchar(60) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_transaksi_detail`
--

INSERT INTO `tbl_transaksi_detail` (`id`, `no_transaksi`, `kd_barang`, `barang`, `harga`, `banyak`, `total`, `konsumen`) VALUES
(5, '16052024001', 'BRG000005', 'Siladex', 15000, 1, 15000, 'Andri'),
(4, '16052024001', 'BRG000002', 'Sanprima', 30000, 1, 30000, 'Andri');

--
-- Trigger `tbl_transaksi_detail`
--
DELIMITER $$
CREATE TRIGGER `hapus_jualbarang` AFTER DELETE ON `tbl_transaksi_detail` FOR EACH ROW UPDATE tbl_barang SET stok = stok+OLD.banyak WHERE kd_barang = OLD.kd_barang
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tambah_jualbarang` AFTER INSERT ON `tbl_transaksi_detail` FOR EACH ROW UPDATE tbl_barang SET stok = stok - NEW.banyak WHERE kd_barang = NEW.kd_barang
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_jualbarang` AFTER UPDATE ON `tbl_transaksi_detail` FOR EACH ROW UPDATE tbl_barang SET stok = (stok+OLD.banyak) - NEW.banyak WHERE kd_barang =NEW.Kd_barang
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_type_user`
--

CREATE TABLE `tbl_type_user` (
  `type_user` int(1) NOT NULL,
  `jabatan` varchar(7) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_type_user`
--

INSERT INTO `tbl_type_user` (`type_user`, `jabatan`) VALUES
(1, 'Manager'),
(2, 'Admin'),
(3, 'Kasir');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_user`
--

CREATE TABLE `tbl_user` (
  `id_user` int(11) NOT NULL,
  `nama_user` varchar(50) NOT NULL,
  `jk_user` varchar(9) NOT NULL,
  `alamat_user` text NOT NULL,
  `no_telp_user` varchar(13) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(30) NOT NULL,
  `type_user` int(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_user`
--

INSERT INTO `tbl_user` (`id_user`, `nama_user`, `jk_user`, `alamat_user`, `no_telp_user`, `username`, `password`, `type_user`) VALUES
(3, 'admin', 'Laki-Laki', 'Bandar Lampung', '08381187323', 'admin', 'admin123', 2),
(4, 'Pimpinan', 'Laki-Laki', 'Bandar Lampung', '0998123134', 'pimpinan', 'pimpinan123', 1),
(5, 'Rivaldo', 'laki-laki', 'bandar lampung', '085744773377', 'kasir', 'kasir123', 3);

-- --------------------------------------------------------

--
-- Struktur untuk view `qw_barang`
--
DROP TABLE IF EXISTS `qw_barang`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `qw_barang`  AS  select `tbl_barang`.`kd_barang` AS `kd_barang`,`tbl_barang`.`nama_barang` AS `nama_barang`,`tbl_barang`.`id_jenis` AS `id_jenis`,`tbl_barang`.`satuan` AS `satuan`,`tbl_barang`.`stok` AS `stok`,`tbl_barang`.`harga_pokok` AS `harga_pokok`,`tbl_barang`.`ppn` AS `ppn`,`tbl_barang`.`harga_jual` AS `harga_jual`,`tbl_jenis`.`jenis` AS `jenis` from (`tbl_barang` join `tbl_jenis` on((`tbl_jenis`.`id_jenis` = `tbl_barang`.`id_jenis`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `qw_barang_masuk`
--
DROP TABLE IF EXISTS `qw_barang_masuk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `qw_barang_masuk`  AS  select `tbl_barang_masuk`.`kd_barang_masuk` AS `kd_barang_masuk`,`tbl_barang_masuk`.`kd_supplier` AS `kd_supplier`,`tbl_barang_masuk`.`kd_barang` AS `kd_barang`,`tbl_barang_masuk`.`nama_barang` AS `nama_barang`,`tbl_barang_masuk`.`satuan` AS `satuan`,`tbl_barang_masuk`.`harga` AS `harga`,`tbl_barang_masuk`.`jumlah` AS `jumlah`,`tbl_barang_masuk`.`total_harga` AS `total_harga`,`tbl_barang_masuk`.`tanggal` AS `tanggal`,`tbl_supplier`.`nama_supplier` AS `nama_supplier` from (`tbl_barang_masuk` join `tbl_supplier` on((`tbl_supplier`.`kd_supplier` = `tbl_barang_masuk`.`kd_supplier`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `qw_transaksi`
--
DROP TABLE IF EXISTS `qw_transaksi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `qw_transaksi`  AS  select `tbl_transaksi`.`no_transaksi` AS `no_transaksi`,`tbl_transaksi`.`tgl_transaksi` AS `tgl_transaksi`,`tbl_transaksi`.`waktu` AS `waktu`,`tbl_transaksi`.`id_kasir` AS `id_kasir`,`tbl_transaksi`.`subtotal` AS `subtotal`,`tbl_transaksi`.`diskon` AS `diskon`,`tbl_transaksi`.`total_akhir` AS `total_akhir`,`tbl_transaksi`.`bayar` AS `bayar`,`tbl_transaksi`.`kembalian` AS `kembalian`,`tbl_user`.`nama_user` AS `nama_kasir` from (`tbl_transaksi` join `tbl_user` on((`tbl_user`.`username` = `tbl_transaksi`.`id_kasir`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `qw_user`
--
DROP TABLE IF EXISTS `qw_user`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `qw_user`  AS  select `tbl_user`.`id_user` AS `id_user`,`tbl_user`.`nama_user` AS `nama_user`,`tbl_user`.`jk_user` AS `jk_user`,`tbl_user`.`alamat_user` AS `alamat_user`,`tbl_user`.`no_telp_user` AS `no_telp_user`,`tbl_user`.`username` AS `username`,`tbl_user`.`password` AS `password`,`tbl_user`.`type_user` AS `type_user`,`tbl_type_user`.`jabatan` AS `jabatan` from (`tbl_user` join `tbl_type_user` on((`tbl_type_user`.`type_user` = `tbl_user`.`type_user`))) ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tbl_barang`
--
ALTER TABLE `tbl_barang`
  ADD PRIMARY KEY (`kd_barang`);

--
-- Indeks untuk tabel `tbl_barang_masuk`
--
ALTER TABLE `tbl_barang_masuk`
  ADD PRIMARY KEY (`kd_barang_masuk`);

--
-- Indeks untuk tabel `tbl_jenis`
--
ALTER TABLE `tbl_jenis`
  ADD PRIMARY KEY (`id_jenis`);

--
-- Indeks untuk tabel `tbl_keuangan`
--
ALTER TABLE `tbl_keuangan`
  ADD PRIMARY KEY (`id_keuangan`);

--
-- Indeks untuk tabel `tbl_supplier`
--
ALTER TABLE `tbl_supplier`
  ADD PRIMARY KEY (`kd_supplier`),
  ADD UNIQUE KEY `no_telp_supplier` (`no_telp_supplier`),
  ADD UNIQUE KEY `kd_supplier` (`kd_supplier`);

--
-- Indeks untuk tabel `tbl_transaksi`
--
ALTER TABLE `tbl_transaksi`
  ADD PRIMARY KEY (`no_transaksi`);

--
-- Indeks untuk tabel `tbl_transaksi_detail`
--
ALTER TABLE `tbl_transaksi_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tbl_type_user`
--
ALTER TABLE `tbl_type_user`
  ADD PRIMARY KEY (`type_user`);

--
-- Indeks untuk tabel `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `no_telp_user` (`no_telp_user`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tbl_jenis`
--
ALTER TABLE `tbl_jenis`
  MODIFY `id_jenis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT untuk tabel `tbl_keuangan`
--
ALTER TABLE `tbl_keuangan`
  MODIFY `id_keuangan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `tbl_transaksi_detail`
--
ALTER TABLE `tbl_transaksi_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `tbl_type_user`
--
ALTER TABLE `tbl_type_user`
  MODIFY `type_user` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
