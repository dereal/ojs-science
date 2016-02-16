{**
 * templates/subscription/subscriptionPolicyForm.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Setup subscription policies.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.subscriptionPolicies"}
{assign var="pageId" value="manager.subscriptionPolicies"}
{include file="common/header.tpl"}
{/strip}

<ul class="stay">
	<li><a href="{url op="subscriptionsSummary"}">{translate key="manager.subscriptions.summary"}</a></li>
	<li><a href="{url op="subscriptions" path="individual"}">{translate key="manager.individualSubscriptions"}</a></li>
	<li><a href="{url op="subscriptions" path="institutional"}">{translate key="manager.institutionalSubscriptions"}</a></li>
	<li><a href="{url op="subscriptionTypes"}">{translate key="manager.subscriptionTypes"}</a></li>
	<li class="current"><a href="{url op="subscriptionPolicies"}">{translate key="manager.subscriptionPolicies"}</a></li>
	<li><a href="{url op="payments"}">{translate key="manager.payments"}</a></li>
</ul>

{if $subscriptionPoliciesSaved}
	<br/>
	{translate key="manager.subscriptionPolicies.subscriptionPoliciesSaved"}<br />
{/if}

<form role="form" id="subscriptionPolicies" method="post" action="{url op="saveSubscriptionPolicies"}">
	
	{include file="common/formErrors.tpl"}

	<script type="text/javascript">
		{literal}
		<!--
			function toggleAllowSetDelayedOpenAccessDuration(form) {
				form.delayedOpenAccessDuration.disabled = !form.delayedOpenAccessDuration.disabled;
			}
			function toggleAllowSetBeforeMonthsReminder(form) {
				form.numMonthsBeforeSubscriptionExpiryReminder.disabled = !form.numMonthsBeforeSubscriptionExpiryReminder.disabled;
			}
			function toggleAllowSetBeforeWeeksReminder(form) {
				form.numWeeksBeforeSubscriptionExpiryReminder.disabled = !form.numWeeksBeforeSubscriptionExpiryReminder.disabled;
			}
			function toggleAllowSetAfterMonthsReminder(form) {
				form.numMonthsAfterSubscriptionExpiryReminder.disabled = !form.numMonthsAfterSubscriptionExpiryReminder.disabled;
			}
			function toggleAllowSetAfterWeeksReminder(form) {
				form.numWeeksAfterSubscriptionExpiryReminder.disabled = !form.numWeeksAfterSubscriptionExpiryReminder.disabled;
			}
		// -->
		{/literal}
	</script>

	<div id="subscriptionContact" class="col-md-12 mag-innert-left">
		<h3>{translate key="manager.subscriptionPolicies.subscriptionContact"}</h3>
		<p class="help-block">{translate key="manager.subscriptionPolicies.subscriptionContactDescription"}</p>
		
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				{if count($formLocales) > 1}
					<tr valign="top">
						<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
						<td width="80%" class="value">
							{url|assign:"subscriptionPoliciesUrl" op="subscriptionPolicies" escape=false}
							{form_language_chooser form="subscriptionPolicies" url=$subscriptionPoliciesUrl}
							<p class="help-block">{translate key="form.formLanguage.description"}</p>
						</td>
					</tr>
				{/if}
				<tr valign="top">
					<td width="20%">{fieldLabel name="subscriptionName" key="user.name"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" name="subscriptionName" id="subscriptionName" value="{$subscriptionName|escape}" size="30" maxlength="60" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="subscriptionEmail" key="user.email"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" name="subscriptionEmail" id="subscriptionEmail" value="{$subscriptionEmail|escape}" size="30" maxlength="90" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="subscriptionPhone" key="user.phone"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" name="subscriptionPhone" id="subscriptionPhone" value="{$subscriptionPhone|escape}" size="15" maxlength="24" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="subscriptionFax" key="user.fax"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" name="subscriptionFax" id="subscriptionFax" value="{$subscriptionFax|escape}" size="15" maxlength="24" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="subscriptionMailingAddress" key="common.mailingAddress"}</td>
					<td width="80%" class="value"><div class="form-group"><textarea name="subscriptionMailingAddress" id="subscriptionMailingAddress" rows="6" cols="40" class="form-control">{$subscriptionMailingAddress|escape}</textarea></div></td>
				</tr>
			</table>
		</div>
	</div>

	<div class="separator"></div>

	<div id="additionalInformation">
		<h3>{translate key="manager.subscriptionPolicies.subscriptionAdditionalInformation"}</h3>
		<p class="help-block">{translate key="manager.subscriptionPolicies.subscriptionAdditionalInformationDescription"}</p>
		<p>
			<div class="form-group">
				<textarea name="subscriptionAdditionalInformation[{$formLocale|escape}]" id="subscriptionAdditionalInformation" rows="12" cols="60" class="form-control">{$subscriptionAdditionalInformation[$formLocale]|escape}</textarea>
				<br />
				<p class="help-block">{translate key="manager.subscriptionPolicies.htmlInstructions"}</p>
			</div>
		</p>
	</div>

	<div class="separator"></div>

	<div id="expiry">
		<h3>{translate key="manager.subscriptionPolicies.expiry"}</h3>
		<p class="help-block">{translate key="manager.subscriptionPolicies.expiryDescription"}</p>
		<p class="help-block">{translate key="manager.subscriptionPolicies.expirySelectOne"}</p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="5%" align="right">
						<div class="form-group"><input type="radio" name="subscriptionExpiryPartial" id="subscriptionExpiryPartial-0" value="0"{if not $subscriptionExpiryPartial} checked="checked"{/if} /></div>
					</td>
					<td width="95%" class="value">
						<strong>{fieldLabel name="subscriptionExpiryPartial-0" key="manager.subscriptionPolicies.expiryFull"}</strong>
						<br />
						<p class="help-block">{translate key="manager.subscriptionPolicies.expiryFullDescription"}</p>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="separator">&nbsp;</td>
				</tr>
				<tr valign="top">
					<td width="5%" align="right">
						<div class="form-group"><input type="radio" name="subscriptionExpiryPartial" id="subscriptionExpiryPartial-1" value="1"{if $subscriptionExpiryPartial} checked="checked"{/if} /></div>
					</td>
					<td width="95%" class="value">
						<strong>{fieldLabel name="subscriptionExpiryPartial-1" key="manager.subscriptionPolicies.expiryPartial"}</strong>
						<br />
						<p class="help-block">{translate key="manager.subscriptionPolicies.expiryPartialDescription"}</p>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="separator"></div>

	<div id="expiryReminders">
		<h3>{translate key="manager.subscriptionPolicies.expiryReminders"}</h3>
		<p class="help-block">{translate key="manager.subscriptionPolicies.expiryRemindersDescription"}</p>
		<p>
			<div class="form-group">
				<input type="checkbox" name="enableSubscriptionExpiryReminderBeforeMonths" id="enableSubscriptionExpiryReminderBeforeMonths" value="1" onclick="toggleAllowSetBeforeMonthsReminder(this.form)"{if !$scheduledTasksEnabled} disabled="disabled" {elseif $enableSubscriptionExpiryReminderBeforeMonths} checked="checked"{/if} />&nbsp;
				{fieldLabel name="enableSubscriptionExpiryReminderBeforeMonths" key="manager.subscriptionPolicies.expiryReminderBeforeMonths1"}
			</div>
			<div class="form-group">
				<select name="numMonthsBeforeSubscriptionExpiryReminder" id="numMonthsBeforeSubscriptionExpiryReminder" class="form-control"{if not $enableSubscriptionExpiryReminderBeforeMonths || !$scheduledTasksEnabled} disabled="disabled"{/if}>{html_options options=$validNumMonthsBeforeExpiry selected=$numMonthsBeforeSubscriptionExpiryReminder}</select>
				{fieldLabel name="numMonthsBeforeSubscriptionExpiryReminder" key="manager.subscriptionPolicies.expiryReminderBeforeMonths2"}
			</div>
		</p>
		<p>
			<div class="form-group">
				<input type="checkbox" name="enableSubscriptionExpiryReminderBeforeWeeks" id="enableSubscriptionExpiryReminderBeforeWeeks" value="1" onclick="toggleAllowSetBeforeWeeksReminder(this.form)"{if !$scheduledTasksEnabled} disabled="disabled" {elseif $enableSubscriptionExpiryReminderBeforeWeeks} checked="checked"{/if} />&nbsp;
				{fieldLabel name="enableSubscriptionExpiryReminderBeforeWeeks" key="manager.subscriptionPolicies.expiryReminderBeforeWeeks1"}
			</div>
			<div class="form-group">
				<select name="numWeeksBeforeSubscriptionExpiryReminder" id="numWeeksBeforeSubscriptionExpiryReminder" class="form-control"{if not $enableSubscriptionExpiryReminderBeforeWeeks || !$scheduledTasksEnabled} disabled="disabled"{/if}>{html_options options=$validNumWeeksBeforeExpiry selected=$numWeeksBeforeSubscriptionExpiryReminder}</select>
				{fieldLabel name="numWeeksBeforeSubscriptionExpiryReminder" key="manager.subscriptionPolicies.expiryReminderBeforeWeeks2"}
			</div>
		</p>
		<p>
			<div class="form-group">
				<input type="checkbox" name="enableSubscriptionExpiryReminderAfterWeeks" id="enableSubscriptionExpiryReminderAfterWeeks" value="1" onclick="toggleAllowSetAfterWeeksReminder(this.form)"{if !$scheduledTasksEnabled} disabled="disabled" {elseif $enableSubscriptionExpiryReminderAfterWeeks} checked="checked"{/if} />&nbsp;
				{fieldLabel name="enableSubscriptionExpiryReminderAfterWeeks" key="manager.subscriptionPolicies.expiryReminderAfterWeeks1"}
			</div>
			<div class="form-group">
				<select name="numWeeksAfterSubscriptionExpiryReminder" id="numWeeksAfterSubscriptionExpiryReminder" class="form-control"{if not $enableSubscriptionExpiryReminderAfterWeeks || !$scheduledTasksEnabled} disabled="disabled"{/if}>{html_options options=$validNumWeeksAfterExpiry selected=$numWeeksAfterSubscriptionExpiryReminder}</select>
				{fieldLabel name="numWeeksAfterSubscriptionExpiryReminder" key="manager.subscriptionPolicies.expiryReminderAfterWeeks2"}
			</div>
		</p>
		<p>
			<div class="form-group">
				<input type="checkbox" name="enableSubscriptionExpiryReminderAfterMonths" id="enableSubscriptionExpiryReminderAfterMonths" value="1" onclick="toggleAllowSetAfterMonthsReminder(this.form)"{if !$scheduledTasksEnabled} disabled="disabled" {elseif $enableSubscriptionExpiryReminderAfterMonths} checked="checked"{/if} />&nbsp;
				{fieldLabel name="enableSubscriptionExpiryReminderAfterMonths" key="manager.subscriptionPolicies.expiryReminderAfterMonths1"}
			</div>
			<div class="form-group">
				<select name="numMonthsAfterSubscriptionExpiryReminder" id="numMonthsAfterSubscriptionExpiryReminder" class="form-control"{if not $enableSubscriptionExpiryReminderAfterMonths || !$scheduledTasksEnabled} disabled="disabled"{/if}>{html_options options=$validNumMonthsAfterExpiry selected=$numMonthsAfterSubscriptionExpiryReminder}</select>
				{fieldLabel name="numMonthsAfterSubscriptionExpiryReminder" key="manager.subscriptionPolicies.expiryReminderAfterMonths2"}
			</div>
		</p>

		{if !$scheduledTasksEnabled}
			<br/>
			{translate key="manager.subscriptionPolicies.expiryRemindersDisabled"}
		{/if}
	</div>

	<div class="separator"></div>

	<div id="onlinePaymentNotifications">
		<h3>{translate key="manager.subscriptionPolicies.onlinePaymentNotifications"}</h3>
		<p class="help-block">{translate key="manager.subscriptionPolicies.onlinePaymentNotificationsDescription"}</p>
		
		{if $journalPaymentsEnabled && $acceptSubscriptionPayments}
			{assign var=paymentsEnabled value=true}
		{/if}
		
		<p>
			<div class="form-group">
				<input type="checkbox" name="enableSubscriptionOnlinePaymentNotificationPurchaseIndividual" id="enableSubscriptionOnlinePaymentNotificationPurchaseIndividual" value="1" {if !$paymentsEnabled} disabled="disabled" {elseif $enableSubscriptionOnlinePaymentNotificationPurchaseIndividual} checked="checked"{/if} />
				{fieldLabel name="enableSubscriptionOnlinePaymentNotificationPurchaseIndividual" key="manager.subscriptionPolicies.enableSubscriptionOnlinePaymentNotificationPurchaseIndividual"}
			</div>
		</p>
		<p>
			<div class="form-group">
				<input type="checkbox" name="enableSubscriptionOnlinePaymentNotificationPurchaseInstitutional" id="enableSubscriptionOnlinePaymentNotificationPurchaseInstitutional" value="1" {if !$paymentsEnabled} disabled="disabled" {elseif $enableSubscriptionOnlinePaymentNotificationPurchaseInstitutional} checked="checked"{/if} />
				{fieldLabel name="enableSubscriptionOnlinePaymentNotificationPurchaseInstitutional" key="manager.subscriptionPolicies.enableSubscriptionOnlinePaymentNotificationPurchaseInstitutional"}
			</div>
		</p>
		<p>
			<div class="form-group">
				<input type="checkbox" name="enableSubscriptionOnlinePaymentNotificationRenewIndividual" id="enableSubscriptionOnlinePaymentNotificationRenewIndividual" value="1" {if !$paymentsEnabled} disabled="disabled" {elseif $enableSubscriptionOnlinePaymentNotificationRenewIndividual} checked="checked"{/if} />
				{fieldLabel name="enableSubscriptionOnlinePaymentNotificationRenewIndividual" key="manager.subscriptionPolicies.enableSubscriptionOnlinePaymentNotificationRenewIndividual"}
			</div>
		</p>
		<p>
			<div class="form-group">
				<input type="checkbox" name="enableSubscriptionOnlinePaymentNotificationRenewInstitutional" id="enableSubscriptionOnlinePaymentNotificationRenewInstitutional" value="1" {if !$paymentsEnabled} disabled="disabled" {elseif $enableSubscriptionOnlinePaymentNotificationRenewInstitutional} checked="checked"{/if} />
				{fieldLabel name="enableSubscriptionOnlinePaymentNotificationRenewInstitutional" key="manager.subscriptionPolicies.enableSubscriptionOnlinePaymentNotificationRenewInstitutional"}
			</div>
		</p>
		{translate key="manager.subscriptionPolicies.onlinePaymentPurchaseInstitutionalDescription"}
		<br />
		{if !$paymentsEnabled}
			<br />
			{translate key="manager.subscriptionPolicies.onlinePaymentDisabled"}
		{/if}
	</div>

	<div class="separator"></div>

	<div id="openAccessOptions">
		<h3>{translate key="manager.subscriptionPolicies.openAccessOptions"}</h3>
		<p class="help-block">{translate key="manager.subscriptionPolicies.openAccessOptionsDescription"}</p>

		<h4>{translate key="manager.subscriptionPolicies.delayedOpenAccess"}</h4>
		<p class="help-block">{translate key="manager.subscriptionPolicies.delayedOpenAccessDescription"}</p>
		<div class="form-group">
			<input type="checkbox" name="enableDelayedOpenAccess" id="enableDelayedOpenAccess" value="1" onclick="toggleAllowSetDelayedOpenAccessDuration(this.form)" {if $enableDelayedOpenAccess} checked="checked"{/if} />&nbsp;
			{fieldLabel name="enableDelayedOpenAccess" key="manager.subscriptionPolicies.delayedOpenAccessDescription1"}
		</div>
		<div class="form-group">
			<select name="delayedOpenAccessDuration" id="delayedOpenAccessDuration" class="form-control" {if not $enableDelayedOpenAccess} disabled="disabled"{/if}>{html_options options=$validDuration selected=$delayedOpenAccessDuration}</select>
			{fieldLabel name="delayedOpenAccessDuration" key="manager.subscriptionPolicies.delayedOpenAccessDescription2"}
		</div>

		<p>
			<div class="form-group">
				<input type="checkbox" name="enableOpenAccessNotification" id="enableOpenAccessNotification" value="1"{if !$scheduledTasksEnabled} disabled="disabled" {elseif $enableOpenAccessNotification} checked="checked"{/if} />&nbsp;
				{fieldLabel name="enableOpenAccessNotification" key="manager.subscriptionPolicies.openAccessNotificationDescription"}
				{if !$scheduledTasksEnabled}
					<br/>
					{translate key="manager.subscriptionPolicies.openAccessNotificationDisabled"}
				{/if}
			</div>
		</p>

		<p class="help-block">{translate key="manager.subscriptionPolicies.delayedOpenAccessPolicyDescription"}</p>
		<p>
			<div class="form-group">
				<textarea name="delayedOpenAccessPolicy[{$formLocale|escape}]" id="delayedOpenAccessPolicy" rows="12" cols="60" class="form-control">{$delayedOpenAccessPolicy[$formLocale]|escape}</textarea>
				<br />
				<p class="help-block">{translate key="manager.subscriptionPolicies.htmlInstructions"}</p>
			</div>
		</p>

		<h4>{translate key="manager.subscriptionPolicies.authorSelfArchive"}</h4>
		<p>
			<div class="form-group">
				<input type="checkbox" name="enableAuthorSelfArchive" id="enableAuthorSelfArchive" value="1"{if $enableAuthorSelfArchive} checked="checked"{/if} />&nbsp;
				{fieldLabel name="enableAuthorSelfArchive" key="manager.subscriptionPolicies.authorSelfArchiveDescription"}
			</div>
		</p>
		<p>
			<div class="form-group">
				<textarea name="authorSelfArchivePolicy[{$formLocale|escape}]" id="authorSelfArchivePolicy" rows="12" cols="60" class="form-control">{$authorSelfArchivePolicy[$formLocale]|escape}</textarea>
				<br />
				<p class="help-block">{translate key="manager.subscriptionPolicies.htmlInstructions"}</p>
			</div>
		</p>
	</div>

	<div class="separator"></div>


	<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="subscriptionPolicies" escape=false}'" /></p>

	<p class="help-block">{translate key="common.requiredField"}</p>
</form>

{include file="common/footer.tpl"}