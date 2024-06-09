<?php  
	if (!isset($_GET['menu'])) {
	header("location:index.php?menu=daftarpenjualan");
	}

	@$table = "tbl_transaksi";
	@$alamat = "?menu=daftarpenjualan";
	@$where = "no_transaksi = '$_GET[id]'";

	if (isset($_GET['hapus'])) {
		$aksi->hapus($table,$where,$alamat);
		$aksi->hapus("tbl_transaksi_detail",$where,$alamat);
	}

	if (isset($_POST['tbulan']) || isset($_POST['ttahun'])) {
		@$bulanini=$_POST['tbulan'];
		@$tahunini=$_POST['ttahun'];
	}else{
		@$bulanini=date("m");
		@$tahunini=date("Y");
	}
	@$cari="WHERE MONTH(tgl_transaksi)='$bulanini' AND YEAR(tgl_transaksi)='$tahunini'";
	switch ($bulanini) {
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
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE-edge">
	<meta name="viewport" content="window=device-width, initial-scale=1">
	<title>Form Penjualan Barang</title>
</head>
<body>
<br><br><br><br>
<div class="container-fluid" id="mrg">
	<div class="row">
		<div class="col-md-12">
			<div class="panel panel-primary">
				<div class="panel-heading">Daftar Transaksi Penjualan - Bulan <?php echo @$bulaninitext." ".@$tahunini; ?></div>
				<div class="panel-body">
					<form method="post">
						<table class="table-bordered">
							<div class="col-md-5" style="margin-left:-10px;">

								<!-- <br>
								<label>Tampilkan Data Sebanyak :</label>
								<select>
									<option>10</option>
									<option>25</option>
									<option>50</option>
									<option>100</option>
								<label>Baris</label>
								</select> -->
							</div>
							<div class="col-md-1"></div>
							<div class="col-md-6">
								<div class="input-group">
									<div class="input-group-addon" id="pri">Bulan</div>
									<select name="tbulan" class="form-control" onChange="submit()">
										<?php   
											for ($a=1; $a < 13; $a++) { 
										?>	
											<option value="<?php echo $a; ?>"<?php if($a==$bulanini){echo "selected";}?>><?php echo $a; ?></option>
										<?php 	}?>
									</select>
									<div class="input-group-addon" id="pri">Tahun</div>
									<select name="ttahun" class="form-control" onChange="submit()">
										<?php   
											for ($a=2016; $a < 2031; $a++) { 
										?>	
											<option value="<?php echo $a; ?>"<?php if($a==$tahunini){echo "selected";} ?>><?php echo $a; ?></option>
										<?php 	}?>
									</select>
									<div class="input-group-btn">
										<a href="" class="btn btn-success">
											<div class="glyphicon glyphicon-refresh">Refresh</div>
										</a>
									</div>
								</div>			
							</div>
						</table>
						<br><br>
						<br><br>
						<div class="table table-responsive">
							<table class="table table-hover table-bordered table-striped">
								<thead id="pri">
									<th width="4%"><center>No.</center></th>
									<th>No.Transaksi</th>
									<th>Tanggal</th>
									<th>Nama Kasir</th>
									<th>Subtotal</th>
									<th>Diskon</th>
									<th>Total Akhir</th>
									<th>Bayar</th>
									<th>Kembalian</th>
									<th><center>Detail</center></th>
								</thead>
								<tbody>	
									<tr>
										<?php 
											@$t = $aksi->tampil("qw_transaksi",$cari," ORDER by waktu DESC");
											@$no =0;
											if ($t=="") {
												echo "<tr><td colspan='10' align='center'><b>Data Tidak Ada !!!</b></td></tr>";
											}else{
												foreach ($t as $data) {
													$no++;
													
											?>
											<td><center><b><?php echo $no; ?>.</b></center></td>
											<td><?php echo $data[0]; ?></td>
											<td><?php echo $data[1]; ?></td>
											<td><?php echo $data[9]; ?></td>
											<td align="right"><?php echo number_format($data[4],0,'','.'); ?></td>
											<td align="right"><?php echo number_format($data[5],0,'','.'); ?></td>
											<td align="right"><?php echo number_format($data[6],0,'','.'); ?></td>
											<td align="right"><?php echo number_format($data[7],0,'','.'); ?></td>
											<td align="right"><?php echo number_format($data[8],0,'','.'); ?></td>
											<td><center><a href="?menu=detail&no_transaksi=<?php echo $data[0]; ?>"  class="btn btn-primary btn-xs">Detail</a></center></td>
									</tr>
											<?php 	}} ?>
									
									
									
									<?php 
                    	@$ttl = mysql_fetch_array(mysql_query("SELECT SUM(tbl_transaksi_detail.banyak) as 'jbl', sum(tbl_transaksi_detail.total) as 'ttbl', tbl_transaksi.* FROM tbl_transaksi_detail 
					JOIN tbl_transaksi on tbl_transaksi_detail.no_transaksi=tbl_transaksi.no_transaksi WHERE MONTH(tbl_transaksi.waktu)='$bulanini' AND YEAR(tbl_transaksi.waktu)='$tahunini'"));
                    	@$jbl = $ttl['jbl'];
						@$ttbl = $ttl['ttbl'];
                    	
                    			?>


								<tr style="background-color: rgba(44, 62, 80, 0.1);">
									<td colspan="7" align="right"><b>TOTAL PENJUALAN TABUNG GAS KESELURUHAN</b></td>
									<td colspan="2" align="right"><b><?php echo number_format(@$jbl, 0,'','.'); ?></b></td>
									<td colspan="2"></td>
								</tr>							
								<tr style="background-color: rgba(44, 62, 80, 0.1);">
									<td colspan="7" align="right"><b>TOTAL PENDAPATAN PENJUALAN TABUNG GAS KESELURUHAN</b></td>
									<td colspan="2" align="right"><b>Rp. <?php echo number_format(@$ttbl, 0,'','.'); ?></b></td>
									<td colspan="2"></td>
								</tr>							
								</tbody>
							</table>
						</div>
					</form>
				</div>
				<div class="panel-footer">&nbsp;</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>