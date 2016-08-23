<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta name="viewport" content="width=device-width"/>
	<link rel="stylesheet" href="css/customize.css">
	<link rel="stylesheet" href="css/foundation-emails.css">
</head>
<body>
<table class="body">
	<tr>
		<td class="center" align="center" valign="top">
			<center>
				<table class="container">
					<tr>
						<td>
							<!-- Header -->
							{transaction.header}

							<table class="row">
								<tr>
									<td class="wrapper last">
										<table class="twelve columns">
											<tr>
												<td class="text-pad">
													<p>Thank you for signing {$petition.title}.</p>

													<p>In order to <b>complete your signature</b>, we must confirm your e-mail.
													<br />
													Please do so by visiting the following web page by clicking
													on the link below or pasting the link into your browser.
													<br /><br />
													Email confirmation page: <a href="{$petition.confirmUrl} ">{$petition.confirmUrl}</a></p>

													<p>If you did not sign this petition, please ignore this message.</p>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
							<!-- Footer -->
							{transaction.footer}

						</td>
					</tr>
				</table>
			</center>
		</td>
	</tr>
</table>

</body>
</html>
