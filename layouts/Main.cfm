<cfoutput>
	<!DOCTYPE html>
	<html lang="en">
		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>Dashboard - Mazer Admin Dashboard</title>

			<link rel="stylesheet" href="/includes/assets/css/main/app.css">
			<link rel="stylesheet" href="/includes/assets/css/main/app-dark.css">
			<link rel="shortcut icon" href="/includes/assets/images/logo/favicon.svg" type="image/x-icon">
			<link rel="shortcut icon" href="/includes/assets/images/logo/favicon.png" type="image/png">
			<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/hummingbird-dev/hummingbird-treeview@v3.0.5/hummingbird-treeview.min.css">
			<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
			<link rel="stylesheet" href="/includes/assets/css/shared/iconly.css">
			<script src="/includes/assets/extensions/jquery/jquery.min.js"></script>
			<script src="https://cdn.jsdelivr.net/gh/hummingbird-dev/hummingbird-treeview@v3.0.5/hummingbird-treeview.min.js"></script>
			<!--- <script src="https://unpkg.com/swup@3"></script> --->
			<!-- Need: Apexcharts -->
			<script src="/includes/assets/extensions/apexcharts/apexcharts.min.js"></script>
		</head>

		<body>
			<div id="app">
				<div id="spinner" class="d-flex align-items-center justify-content-center">
					<img src="/includes/assets/images/svg-loaders/ball-triangle.svg" class="mx-auto d-block" alt="Loader">
				</div>
				#renderView( "common/sidebar" )#
				<div id="main">
					#renderView( "common/header" )#

					#cbMessageBox().renderIt()#

					#renderView()#

					#renderView( "common/footer" )#
				</div>
			</div>
			<script>
				// const swup = new Swup();
				$(document).ready(function () {
					$('##spinner').addClass('d-none');
				});
			</script>
			<script src="/includes/assets/js/bootstrap.js"></script>
			<script src="/includes/assets/js/app.js"></script>
			<script src="/includes/assets/js/pages/dashboard.js"></script>
		</body>
	</html>
</cfoutput>
