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
													<p>{ts}Dear supporter{/ts},</p>
													<p>{ts 1="$contribPageTitle"}Thanks for creating a personal campaign page in support of %1.{/ts}</p>
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

									{if $pcpStatus eq 'Approved'}
									<tr>
										<td class="panel combined">
										<h3>Promoting Your Page</h3>
										<table>
										{if $isTellFriendEnabled}
											<tr>
												<td>
													<p>{ts}You can begin your fundraising efforts using our "Tell a Friend" form{/ts}:</p>
													<ol>
														<li><a href="{$loginUrl}">{ts}Login to your account{/ts}</a></li>
														<li><a href="{$pcpTellFriendURL}">{ts}Click this link and follow the prompts{/ts}</a></li>
													</ol>
												</td>
											</tr>
											{else}
											<tr>
												<td>
													<p>{ts}Send email to family, friends and colleagues with a personal message about this campaign.{/ts}
													{ts}Include this link to your fundraising page in your emails{/ts}: {$pcpInfoURL}</p>
												</td>
											 </tr>
										{/if}
										</table>
										</td>
									</tr>

									<tr>
								<td class="panel combined">
								<h3>{ts}Managing Your Page{/ts}</h3>
								<table>
									<tr>
										<td>
											<p>{ts}Whenever you want to preview, update or promote your page{/ts}:</p>
											<ol>
											  <li><a href="{$loginUrl}">{ts}Login to your account{/ts}</a></li>
											  <li><a href="{$pcpInfoURL}">{ts}Go to your page{/ts}</a></li>
											</ol>
										</td>
									  </tr>
									  <tr>
										<td>
											<p>{ts}When you view your campaign page WHILE LOGGED IN, the page includes links to edit your page, tell friends, and update your contact info.{/ts}</p>
										</td>
								   </tr>
								  </table>
								 </td>
								</tr>

								{elseif $pcpStatus EQ 'Waiting Review'}

								<tr>
									<td class="text-pad">
									<table>
										<tr>
											<td>
											  <p>{ts}Your page requires administrator review before you can begin your fundraising efforts.{/ts}</p>
											  <p>{ts}A notification email has been sent to the site administrator, and you will receive another notification from them as soon as the review process is complete.{/ts}</p>
											  <p>{ts}You can still preview your page prior to approval{/ts}:</p>
											  <ol>
											   <li><a href="{$loginUrl}">{ts}Login to your account{/ts}</a></li>
											   <li><a href="{$pcpInfoURL}">{ts}Click this link{/ts}</a></li>
											  </ol>
											</td>
										</tr>
									</table>
									</td>
								</tr>
								{/if}

							   {if $pcpNotifyEmailAddress}
								<tr>
									<td class="text-pad">
									<table>
										<tr>
										 <td>
										  <p>{ts}Questions? Send email to{/ts}: {$pcpNotifyEmailAddress}</p>
										 </td>
										</tr>
									  </table>
									  </td>
									</tr>
							   {/if}

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
