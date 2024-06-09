<?php  
	include "../config/koneksi.php";
	include "../library/fungsi.php";
	@session_start();
	date_default_timezone_set("Asia/Jakarta");

	@$aksi = new oop();
	@$table = "tb_transaksi";
	@$bln = $_GET['bln'];
	@$thn = $_GET['thn'];

	@$cari="WHERE MONTH(tanggal)='$bln' AND YEAR(tanggal)='$thn' AND status='Pengembalian'";
	switch ($bln) {
		case '1': @$bulaninitext="Januari"; break;
		case '2': @$bulaninitext="Februari"; break;
		case '3': @$bulaninitext="Maret"; break;
		case '4': @$bulaninitext="April"; break;
		case '5': @$bulaninitext="Mei"; break;
		case '6': @$bulaninitext="Juni"; break;
		case '7': @$bulaninitext="Juli"; break;
		case '8': @$bulaninitext="Agustus"; break;
		case '9': @$bulaninitext="September"; break;
		case '10': @$bulaninitext="Oktober"; break;
		case '11': @$bulaninitext="Novemmber"; break;
		case '12': @$bulaninitext="Desember"; break;
		default: @$bulaninitext=""; break;
	}

	$blnini=date("m");
	switch ($blnini) {
		case '1': @$blnskrg="Januari"; break;
		case '2': @$blnskrg="Februari"; break;
		case '3': @$blnskrg="Maret"; break;
		case '4': @$blnskrg="April"; break;
		case '5': @$blnskrg="Mei"; break;
		case '6': @$blnskrg="Juni"; break;
		case '7': @$blnskrg="Juli"; break;
		case '8': @$blnskrg="Agustus"; break;
		case '9': @$blnskrg="September"; break;
		case '10': @$blnskrg="Oktober"; break;
		case '11': @$blnskrg="Novemmber"; break;
		case '12': @$blnskrg="Desember"; break;
		default: @$blnskrg=""; break;
	}
	$hrini=date("N");
	switch ($hrini) {
		case '1': @$hrskrg="Senin"; break;
		case '2': @$hrskrg="Selasa"; break;
		case '3': @$hrskrg="Rabu"; break;
		case '4': @$hrskrg="Kamis"; break;
		case '5': @$hrskrg="Jumat"; break;
		case '6': @$hrskrg="Sabtu"; break;
		case '7': @$hrskrg="Minggu"; break;
		default: @$hrskrg=""; break;
	}
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, intial-scale=1">
	<title>Cetak Trasnsaksi Sewa Bulanan - Bulan <?php echo $bulaninitext." ".$thn; ?></title>
	<link rel="icon" href="../img/logo1.png">
<body onLoad="window.print()" style="font-family:'Trebuchet MS', 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', Tahoma,  sans-serif;width:21cm;">
		<table width="100%" border="0" cellpadding="2" cellspacing="0">
			<thead>
				<tr>

				 	<td colspan="7" align="center">
					
				 		<h1 style="margin:0">STORE MASLYTA OUTDOOR</h1>
				 		<h4 style="margin:0;margin-top:4px;">Jl. Alamsyah RPN, Gg. Manggasari No.45, Kec. Kotabumi Selatan, Lampung Utara.</h4>
				 	</td>
				</tr>
				
				<tr><td colspan="7"><hr></td></tr>
				
				<tr>
				 	<td colspan="7" align="center"><h3 align="center">Daftar Transaksi Sewa Bulanan - Bulan <?php echo @$bulaninitext." ".@$thn; ?></h3></td>
				</tr>

				<tr>
							<th width="8%" style="border:1px solid black"><center>No.</center></th>
							<th width="10%" style="border:1px solid black"><center>Tanggal</center></th>
							<th width="10%" style="border:1px solid black">No. Transaksi</th>
							<th width="10%" style="border:1px solid black">Total Bayar</th>
							<th width="10%" style="border:1px solid black">Denda</th>
							<th  width="10%" style="border:1px solid black"><center>Jumlah Total Bayar</center></th>
							<th width="10%" style="border:1px solid black">Status</th>

				</tr>
			</thead>
			<tbody>
				<?php  
					$sql = $aksi->tampil($table,$cari,"ORDER BY no_transaksi DESC");
					@$no = 0;
					if ($sql =="") {
						echo "<tr><td align='center' colspan='4'><b>Data Tidak Ada</b></td></tr>";
					}else{
						foreach ($sql as $data) {
							$no++;
				?>
					<tr>
									<td style="border:1px solid black"><center><?php echo $no; ?>.</center></td>
									<td style="border:1px solid black"><center><?php echo $data[1]; ?></center></td>
									<td style="border:1px solid black"><?php echo $data[0]; ?></td>
									<td align="right" style="border:1px solid black"><?php echo number_format($data[7],0,'','.'); ?></td>
									<td align="right" style="border:1px solid black"><?php echo number_format($data[9],0,'','.'); ?></td>
									<td align="right" style="border:1px solid black"><?php echo number_format($data[10],0,'','.'); ?></td>
									<td style="border:1px solid black"><?php echo $data[12]; ?></td>
					</tr>
				<?php } } 
					@$ttl = mysql_query("SELECT SUM(jumlah_total_bayar) AS total_seluruh FROM tb_transaksi WHERE MONTH(tanggal)='$bln' AND YEAR(tanggal)='$thn'");
					@$tl = mysql_fetch_array($ttl);
					@$total = $tl['total_seluruh'];
				?>
				<tr>
					<td colspan="6" align="right" style="border:1px solid black"><b>Total Pendapatan :</b></td>
					<td align="right" style="border:1px solid black;padding-right:10px"><b>Rp. <?php echo number_format(@$total,0,'','.'); ?></b></td>
				</tr>
			</tbody>

		</table>
		<table align="right" style="margin-right:40px;">
			<tr><td rowspan="10" width="50px"></td><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td align="center"><?php echo $hrskrg.", ".date(" j ").$blnskrg.date(" Y "); ?></td>
			</tr>
			<tr>
				<td align="center">Hormat Saya,</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td align="center"><?php echo $_SESSION['nama']; ?></td>
			</tr>
			<tr><td>&nbsp;</td></tr>
		</table>
</body>
</html>