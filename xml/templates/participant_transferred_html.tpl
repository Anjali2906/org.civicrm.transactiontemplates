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
													<p>Dear {contact.display_name},</p>
													<p>{ts 1=$to_participant}Your Event Registration has been Transferred to %1.{/ts}</p>
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
											<h3>{ts}Event Information and Location{/ts}</h3>
											<table>
												<tr>
													<td><strong>{$event.event_title}</strong></td>
												</tr>
												<tr>
													<td>
														{$event.event_start_date|crmDate}
														{if $event.event_end_date}-
															{if $event.event_end_date|date_format:"%Y%m%d" == $event.event_start_date|date_format:"%Y%m%d"}
																{$event.event_end_date|crmDate:0:1}
															{else}
																{$event.event_end_date|crmDate}
															{/if}
														{/if}
													</td>
												</tr>
											</table>
											</td>
											<td class="expander"></td>
										</tr>

										<tr>
											<td class="panel combined">
												<h3>{ts}Participant Role{/ts}</h3>
												<table>
													<tr>
														<td>{$participant.role}</td>
													</tr>
												</table>
											</td>
										</tr>

										<tr>
											<td class="panel combined">
												<table>
													{if $isShowLocation}
														{$event.location.address.1.display|nl2br}
													{/if}
												</table>
											</td>
										</tr>

									{if $event.location.phone.1.phone || $event.location.email.1.email}
										<tr>
										 <td class="panel combined">
											<h3>{ts}Event Contacts:{/ts}</h3>
											<table>
												{foreach from=$event.location.phone item=phone}
												 {if $phone.phone}
													<tr>
													 <td class="row-header">
														{if $phone.phone_type}
															{$phone.phone_type_display}
														{else}
															{ts}Phone{/ts}
														{/if}
													 </td>
													 <td>{$phone.phone}</td>
													</tr>
												 {/if}
												{/foreach}
												{foreach from=$event.location.email item=eventEmail}
												 {if $eventEmail.email}
													<tr>
													 <td class="row-header">
														{ts}Email{/ts}
													 </td>
													 <td>{$eventEmail.email}</td>
													</tr>
												 {/if}
												{/foreach}

												{if $contact.email}
													<tr>
													 <td class="row-header">
														{ts}Registered Email{/ts}
													 </td>
													 <td>{$contact.email}</td>
													</tr>
												{/if}

												 {if $register_date}
													<tr>
													 <td class="row-header">
														{ts}Registration Date{/ts}
													 </td>
													 <td>{$participant.register_date|crmDate}</td>
													</tr>
												{/if}
											</table>
										 </td>
										</tr>
									{/if}
								</table>
								</td>
								</tr>
							</table>

							<table class="row">
								<tr>
								  <td class="wrapper last">
									<table class="twelve columns">
											<tr>
												<td class="text-pad">
													<p>{ts 1=$domain.phone 2=$domain.email}Please contact us at %1 or send email to %2 if you have questions.{/ts}</p>
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
