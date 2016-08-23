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
												  <p>{ts}You have received a donation at your personal page{/ts}: <a href="{$pcpInfoURL}">{$page_title}</a></p>
												  <p>{ts}Your fundraising total has been updated.{/ts}<br/>
													{ts}The donor's information is listed below.  You can choose to contact them and convey your thanks if you wish.{/ts} <br/>
													{if $is_honor_roll_enabled}
													  {ts}The donor's name has been added to your honor roll unless they asked not to be included.{/ts}<br/>
													{/if}
												  </p>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>

							<table class="row">
								<tr>
									<td class="wrapper last">
									<table class="twelve columns">
									<tr>
										<td class="panel empty"></td>
										<td class="expander"></td>
									</tr>

									<tr>
										<td class="panel combined">
										<h3>{ts}Donor's Information{/ts}</h3>
										<table>
											<tr>
												<td class="row-header">{ts}Received{/ts}:</td>
												<td> {$receive_date|crmDate}</td>
											</tr>
										<tr>
											<td class="row-header">{ts}Amount{/ts}:</td>
											<td> {$total_amount|crmMoney:$currency}</td>
										</tr>
										<tr>
											<td class="row-header">{ts}Name{/ts}:</td>
											<td> {$donors_display_name}</td>
										</tr>
										<tr>
											<td class="row-header">{ts}Email{/ts}:</td>
											<td> {$donors_email}</td>
										</tr>
										</table>
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
