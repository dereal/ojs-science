{**
 * templates/manager/setup/step4.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 4 of journal setup.
 *
 *}
{assign var="pageTitle" value="manager.setup.managingTheJournal"}
{include file="manager/setup/setupHeader.tpl"}

<form role="form" id="setupForm" method="post" action="{url op="saveSetup" path="4"}" enctype="multipart/form-data">
	
	{include file="common/formErrors.tpl"}

	{if count($formLocales) > 1}
		<div id="locales" class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td width="80%" class="value">
						{url|assign:"setupFormUrl" op="setup" path="4" escape=false}
						{form_language_chooser form="setupForm" url=$setupFormUrl}
						<p class="help-block">{translate key="form.formLanguage.description"}</p>
					</td>
				</tr>
			</table>
		</div><!-- locales -->
	{/if}

	<div id="securitySettings" class="col-md-12 mag-innert-left">
		<h3>4.1 {translate key="manager.setup.securitySettings"}</h3>
	
		<div id="onlineAccessManagement">
			<h4>{translate key="manager.setup.onlineAccessManagement"}</h4>
	
			<script type="text/javascript">
				{literal}
				<!--
					function togglePublishingMode(form) {
						if (form.publishingMode[0].checked) {
							// PUBLISHING_MODE_OPEN
							form.openAccessPolicy.disabled = false;
							form.showGalleyLinks.disabled = true;
						} else if (form.publishingMode[1].checked) {
							// PUBLISHING_MODE_SUBSCRIPTION
							form.openAccessPolicy.disabled = true;
							form.showGalleyLinks.disabled = false;
						} else {
							// PUBLISHING_MODE_NONE
							form.openAccessPolicy.disabled = true;
							form.showGalleyLinks.disabled = true;
						}
					}
				// -->
				{/literal}
			</script>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="5%" align="right">
							<div class="form-group"><input type="radio" name="publishingMode" id="publishingMode-0" value="{$smarty.const.PUBLISHING_MODE_OPEN}" onclick="togglePublishingMode(this.form)"{if $publishingMode == $smarty.const.PUBLISHING_MODE_OPEN} checked="checked"{/if} /></div>
						</td>
						<td width="95%" class="value">
							<label class="control-label" for="publishingMode-0">{translate key="manager.setup.openAccess"}</label>
							<h4>{translate key="manager.setup.openAccessPolicy"}</h4>
							<p class="help-block">{translate key="manager.setup.openAccessPolicyDescription"}</p>
							<p><div class="form-group"><textarea name="openAccessPolicy[{$formLocale|escape}]" id="openAccessPolicy" rows="12" cols="60" class="form-control"{if $publishingMode != $smarty.const.PUBLISHING_MODE_OPEN} disabled="disabled"{/if}>{$openAccessPolicy[$formLocale]|escape}</textarea></div></p>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="separator">&nbsp;</td>
					</tr>
					<tr valign="top">
						<td width="5%" align="right">
							<div class="form-group"><input type="radio" name="publishingMode" id="publishingMode-1" value="{$smarty.const.PUBLISHING_MODE_SUBSCRIPTION}" onclick="togglePublishingMode(this.form)"{if $publishingMode == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION} checked="checked"{/if} /></div>
						</td>
						<td width="95%" class="value">
							<label class="control-label" for="publishingMode-1">{translate key="manager.setup.subscription"}</label>
							<p class="help-block">{translate key="manager.setup.subscriptionDescription"}</p>
							<table width="100%" class="table table-striped">
								<tr>
									<td width="5%"><div class="form-group"><input type="checkbox" name="showGalleyLinks" id="showGalleyLinks" {if $showGalleyLinks} checked="checked"{/if} /></div></td>
									<td width="95%"><label class="control-label" for="showGalleyLinks">{translate key="manager.setup.showGalleyLinksDescription"}</label></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="separator">&nbsp;</td>
					</tr>
					<tr valign="top">
						<td width="5%" align="right">
							<div class="form-group"><input type="radio" name="publishingMode" id="publishingMode-2" value="{$smarty.const.PUBLISHING_MODE_NONE}" onclick="togglePublishingMode(this.form)"{if $publishingMode == $smarty.const.PUBLISHING_MODE_NONE} checked="checked"{/if} /></div>
						</td>
						<td width="95%" class="value">
							<label class="control-label" for="publishingMode-2">{translate key="manager.setup.noPublishing"}</label>
						</td>
					</tr>
				</table>
			</div>

			<p class="help-block">{translate key="manager.setup.securitySettingsDescription"}</p>
		</div><!-- onlineAccessManagement -->

		<script type="text/javascript">
		{literal}
		<!--
		function setRegAllowOpts(form) {
			if(form.disableUserReg[0].checked) {
				form.allowRegReader.disabled=false;
				form.allowRegAuthor.disabled=false;
				form.allowRegReviewer.disabled=false;
			} else {
				form.allowRegReader.disabled=true;
				form.allowRegAuthor.disabled=true;
				form.allowRegReviewer.disabled=true;
			}
		}
		// -->
		{/literal}
		</script>

		<div id="siteAccess" class="table-responsive">
			<h4>{translate key="manager.setup.siteAccess"}</h4>
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="5%"><div class="form-group"><input type="checkbox" name="restrictSiteAccess" id="restrictSiteAccess" value="1"{if $restrictSiteAccess} checked="checked"{/if} /></div></td>
					<td width="95%" class="value"><label class="control-label" for="restrictSiteAccess">{translate key="manager.setup.restrictSiteAccess"}</label></td>
				</tr>
				<tr valign="top">
					<td width="5%"><div class="form-group"><input type="checkbox" name="restrictArticleAccess" id="restrictArticleAccess" value="1"{if $restrictArticleAccess} checked="checked"{/if} /></div></td>
					<td width="95%" class="value"><label class="control-label" for="restrictArticleAccess">{translate key="manager.setup.restrictArticleAccess"}</label></td>
				</tr>
			</table>
		</div><!-- siteAccess -->

		<div id="userRegistration" class="table-responsive">
			<h4>{translate key="manager.setup.userRegistration"}</h4>

			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="5%"><div class="form-group"><input type="radio" name="disableUserReg" id="disableUserReg-0" value="0" onclick="setRegAllowOpts(this.form)"{if !$disableUserReg} checked="checked"{/if} /></div></td>
					<td width="95%" class="value">
						<label class="control-label" for="disableUserReg-0">{translate key="manager.setup.enableUserRegistration"}</label>
						<table width="100%" class="table table-striped">
							<tr>
								<td width="5%"><div class="form-group"><input type="checkbox" name="allowRegReader" id="allowRegReader" value="1"{if $allowRegReader} checked="checked"{/if}{if $disableUserReg} disabled="disabled"{/if} /></div></td>
								<td width="95%"><label class="control-label" for="allowRegReader">{translate key="manager.setup.enableUserRegistration.reader"}</label></td>
							</tr>
							<tr>
								<td width="5%"><div class="form-group"><input type="checkbox" name="allowRegAuthor" id="allowRegAuthor" value="1"{if $allowRegAuthor} checked="checked"{/if}{if $disableUserReg} disabled="disabled"{/if} /></div></td>
								<td width="95%"><label class="control-label" for="allowRegAuthor">{translate key="manager.setup.enableUserRegistration.author"}</label></td>
							</tr>
							<tr>
								<td width="5%"><div class="form-group"><input type="checkbox" name="allowRegReviewer" id="allowRegReviewer" value="1"{if $allowRegReviewer} checked="checked"{/if}{if $disableUserReg} disabled="disabled"{/if} /></div></td>
								<td width="95%"><label class="control-label" for="allowRegReviewer">{translate key="manager.setup.enableUserRegistration.reviewer"}</label></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr valign="top">
					<td width="5%"><div class="form-group"><input type="radio" name="disableUserReg" id="disableUserReg-1" value="1" onclick="setRegAllowOpts(this.form)"{if $disableUserReg} checked="checked"{/if} /></div></td>
					<td width="95%" class="value"><label class="control-label" for="disableUserReg-1">{translate key="manager.setup.disableUserRegistration"}</label></td>
				</tr>
			</table>
		</div><!-- userRegistration -->
	</div><!-- securitySettings -->

	<div class="separator"></div>

	<div id="publicationScheduling" class="col-md-12 mag-innert-left">
		<h3>4.2 {translate key="manager.setup.publicationScheduling"}</h3>
	
		<div id="publicationSchedule">
			<h4>{translate key="manager.setup.publicationSchedule"}</h4>
			<p class="help-block">{translate key="manager.setup.publicationScheduleDescription"}</p>

			<p><div class="form-group"><textarea name="pubFreqPolicy[{$formLocale|escape}]" id="pubFreqPolicy" rows="12" cols="60" class="form-control">{$pubFreqPolicy[$formLocale]|escape}</textarea></div></p>
		</div>
		
		<div id="publicationFormat">
			<h4>{translate key="manager.setup.publicationFormat"}</h4>
			<p class="help-block">{translate key="manager.setup.publicationFormatDescription"}</p>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="5%"><div class="form-group"><input type="checkbox" name="publicationFormatVolume" id="publicationFormatVolume" value="1"{if ($publicationFormatVolume)} checked="checked"{/if} /></div></td>
						<td width="95%" class="value"><label class="control-label" for="publicationFormatVolume">{translate key="manager.setup.publicationFormatVolume"}</label></td>
					</tr>
					<tr valign="top">
						<td width="5%"><div class="form-group"><input type="checkbox" name="publicationFormatNumber" id="publicationFormatNumber" value="1"{if ($publicationFormatNumber)} checked="checked"{/if} /></div></td>
						<td width="95%" class="value"><label class="control-label" for="publicationFormatNumber">{translate key="manager.setup.publicationFormatNumber"}</label></td>
					</tr>
					<tr valign="top">
						<td width="5%"><div class="form-group"><input type="checkbox" name="publicationFormatYear" id="publicationFormatYear" value="1"{if ($publicationFormatYear)} checked="checked"{/if} /></div></td>
						<td width="95%" class="value"><label class="control-label" for="publicationFormatYear">{translate key="manager.setup.publicationFormatYear"}</label></td>
					</tr>
					<tr valign="top">
						<td width="5%"><div class="form-group"><input type="checkbox" name="publicationFormatTitle" id="publicationFormatTitle" value="1"{if ($publicationFormatTitle)} checked="checked"{/if} /></div></td>
						<td width="95%" class="value">
							<label class="control-label" for="publicationFormatTitle">{translate key="manager.setup.publicationFormatTitle"}</label>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<div id="frequencyOfPublication">
			<h4>{translate key="manager.setup.frequencyOfPublication"}</h4>
			<p class="help-block">{translate key="manager.setup.frequencyOfPublicationDescription"}</p>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="20%">{fieldLabel name="initialNumber" key="issue.number"}</td>
						<td width="80%" class="data"><div class="form-group"><input type="text" name="initialNumber" id="initialNumber" value="{$initialNumber|escape}" size="5" maxlength="8" class="form-control" /></div></td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="initialVolume" key="issue.volume"}</td>
						<td width="80%" class="data"><div class="form-group"><input type="text" name="initialVolume" id="initialVolume" value="{$initialVolume|escape}" size="5" maxlength="8" class="form-control" /></div></td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="initialYear" key="issue.year"}</td>
						<td width="80%" class="data"><div class="form-group"><input type="text" name="initialYear" id="initialYear" value="{$initialYear|escape}" size="5" maxlength="8" class="form-control" /></div></td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="issuePerVolume" key="manager.setup.issuePerVolume"}</td>
						<td width="80%" class="data"><div class="form-group"><input type="text" name="issuePerVolume" id="issuePerVolume" value="{if $issuePerVolume}{$issuePerVolume|escape}{/if}" size="5" maxlength="8" class="form-control" /></div></td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="volumePerYear" key="manager.setup.volumePerYear"}</td>
						<td width="80%" class="data"><div class="form-group"><input type="text" name="volumePerYear" id="volumePerYear" value="{if $volumePerYear}{$volumePerYear|escape}{/if}" size="5" maxlength="8" class="form-control" /></div></td>
					</tr>
				</table>
			</div>

			<p class="help-block">{translate key="manager.setup.frequencyOfPublicationNote"}</p>
		</div>
	</div>

	<div class="separator"></div>

	<div id="publicIdentifier" class="col-md-12 mag-innert-left">
		<h3>4.3 {translate key="manager.setup.publicIdentifier"}</h3>
	
		<div id="uniqueIdentifier">
			<h4>{translate key="manager.setup.uniqueIdentifier"}</h4>
			<p class="help-block">{translate key="manager.setup.uniqueIdentifierDescription"}</p>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="5%"><div class="form-group"><input type="checkbox" name="enablePublicIssueId" id="enablePublicIssueId" value="1"{if $enablePublicIssueId} checked="checked"{/if} /></div></td>
						<td width="95%" class="value"><label class="control-label" for="enablePublicIssueId">{translate key="manager.setup.enablePublicIssueId"}</label></td>
					</tr>
					<tr valign="top">
						<td><div class="form-group"><input type="checkbox" name="enablePublicArticleId" id="enablePublicArticleId" value="1"{if $enablePublicArticleId} checked="checked"{/if} /></div></td>
						<td class="value"><label class="control-label" for="enablePublicArticleId">{translate key="manager.setup.enablePublicArticleId"}</label></td>
					</tr>
					<tr valign="top">
						<td><div class="form-group"><input type="checkbox" name="enablePublicGalleyId" id="enablePublicGalleyId" value="1"{if $enablePublicGalleyId} checked="checked"{/if} /></div></td>
						<td class="value"><label class="control-label" for="enablePublicGalleyId">{translate key="manager.setup.enablePublicGalleyId"}</label></td>
					</tr>
					<tr valign="top">
						<td><div class="form-group"><input type="checkbox" name="enablePublicSuppFileId" id="enablePublicSuppFileId" value="1"{if $enablePublicSuppFileId} checked="checked"{/if} /></div></td>
						<td class="value"><label class="control-label" for="enablePublicSuppFileId">{translate key="manager.setup.enablePublicSuppFileId"}</label></td>
					</tr>
				</table>
			</div>
		</div><!-- uniqueIdentifier -->
	
		<br />
	
		<div id="pageNumberIdentifier" class="table-responsive">
			<h4>{translate key="manager.setup.pageNumberIdentifier"}</h4>
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="5%"><div class="form-group"><input type="checkbox" name="enablePageNumber" id="enablePageNumber" value="1"{if $enablePageNumber} checked="checked"{/if} /></div></td>
					<td width="95%" class="value"><label class="control-label" for="enablePageNumber">{translate key="manager.setup.enablePageNumber"}</label></td>
				</tr>
			</table>
		</div><!-- pageNumberIdentifier -->
	</div><!-- publicIdentifier -->
	
	<div class="separator"></div>

	<div id="announcementsSection" class="col-md-12 mag-innert-left">
		<h3>4.4 {translate key="manager.setup.announcements"}</h3>
		<p class="help-block">{translate key="manager.setup.announcementsDescription"}</p>

		<script type="text/javascript">
			{literal}
			<!--
				function toggleEnableAnnouncementsHomepage(form) {
					form.numAnnouncementsHomepage.disabled = !form.numAnnouncementsHomepage.disabled;
				}
			// -->
			{/literal}
		</script>

		<p>
			<div class="form-group">
				<input type="checkbox" name="enableAnnouncements" id="enableAnnouncements" value="1" {if $enableAnnouncements} checked="checked"{/if} />&nbsp;
				<label class="control-label" for="enableAnnouncements">{translate key="manager.setup.enableAnnouncements"}</label>
			</div>
		</p>

		<p>
			<div class="form-group">
				<input type="checkbox" name="enableAnnouncementsHomepage" id="enableAnnouncementsHomepage" value="1" onclick="toggleEnableAnnouncementsHomepage(this.form)"{if $enableAnnouncementsHomepage} checked="checked"{/if} />&nbsp;
				<label class="control-label" for="enableAnnouncementsHomepage">{translate key="manager.setup.enableAnnouncementsHomepage1"}</label>
			</div>
			<div class="form-group">
				<select name="numAnnouncementsHomepage" size="1" class="form-control" {if not $enableAnnouncementsHomepage}disabled="disabled"{/if}>
					{section name="numAnnouncementsHomepageOptions" start=1 loop=11}
					<option value="{$smarty.section.numAnnouncementsHomepageOptions.index}"{if $numAnnouncementsHomepage eq $smarty.section.numAnnouncementsHomepageOptions.index or ($smarty.section.numAnnouncementsHomepageOptions.index eq 1 and not $numAnnouncementsHomepage)} selected="selected"{/if}>{$smarty.section.numAnnouncementsHomepageOptions.index}</option>
					{/section}
				</select>
			</div>
			<p class="help-block">{translate key="manager.setup.enableAnnouncementsHomepage2"}</p>
		</p>
		
		<div id="announcementsIntroductionSection">
			<h4>{translate key="manager.setup.announcementsIntroduction"}</h4>
			<p class="help-block">{translate key="manager.setup.announcementsIntroductionDescription"}</p>

			<p><div class="form-group"><textarea name="announcementsIntroduction[{$formLocale|escape}]" id="announcementsIntroduction" rows="12" cols="60" class="form-control">{$announcementsIntroduction[$formLocale]|escape}</textarea></div></p>
		</div><!-- announcementsIntroductionSection -->
	</div><!-- announcementsSection -->

	<div class="separator"></div>

	<div id="copyediting" class="col-md-12 mag-innert-left">
		<h3>4.5 {translate key="manager.setup.copyediting"}</h3>
		<p class="help-block">{translate key="manager.setup.selectOne"}:</p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="5%"><div class="form-group"><input type="radio" name="useCopyeditors" id="useCopyeditors-1" value="1"{if $useCopyeditors} checked="checked"{/if} /></div></td>
					<td width="95%" class="value"><label class="control-label" for="useCopyeditors-1">{translate key="manager.setup.useCopyeditors"}</label></td>
				</tr>
				<tr valign="top">
					<td width="5%"><div class="form-group"><input type="radio" name="useCopyeditors" id="useCopyeditors-0" value="0"{if !$useCopyeditors} checked="checked"{/if} /></div></td>
					<td width="95%" class="value"><label class="control-label" for="useCopyeditors-0">{translate key="manager.setup.noUseCopyeditors"}</label></td>
				</tr>
			</table>
		</div>
	</div><!-- copyediting -->

	<div id="copyeditInstructionsSection" class="col-md-12 mag-innert-left">
		<h4>{translate key="manager.setup.copyeditInstructions"}</h4>
		<p class="help-block">{translate key="manager.setup.copyeditInstructionsDescription"}</p>

		<p>
			<div class="form-group"><textarea name="copyeditInstructions[{$formLocale|escape}]" id="copyeditInstructions" rows="12" cols="60" class="form-control">{$copyeditInstructions[$formLocale]|escape}</textarea></div>
		</p>
	</div><!-- copyeditInstructionsSection -->

	<div class="separator"></div>

	<div id="layoutAndGalleys" class="col-md-12 mag-innert-left">
		<h3>4.6 {translate key="manager.setup.layoutAndGalleys"}</h3>
		<p class="help-block">{translate key="manager.setup.selectOne"}:</p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="5%"><div class="form-group"><input type="radio" name="useLayoutEditors" id="useLayoutEditors-1" value="1"{if $useLayoutEditors} checked="checked"{/if} /></div></td>
					<td width="95%" class="value"><label class="control-label" for="useLayoutEditors-1">{translate key="manager.setup.useLayoutEditors"}</label></td>
				</tr>
				<tr valign="top">
					<td width="5%"><div class="form-group"><input type="radio" name="useLayoutEditors" id="useLayoutEditors-0" value="0"{if !$useLayoutEditors} checked="checked"{/if} /></div></td>
					<td width="95%" class="value"><label class="control-label" for="useLayoutEditors-0">{translate key="manager.setup.noUseLayoutEditors"}</label></td>
				</tr>
			</table>
		</div>

		<div id="layoutInstructionsSection">
			<h4>{translate key="manager.setup.layoutInstructions"}</h4>
			<p class="help-block">{translate key="manager.setup.layoutInstructionsDescription"}</p>

			<p>
				<div class="form-group"><textarea name="layoutInstructions[{$formLocale|escape}]" id="layoutInstructions" rows="12" cols="60" class="form-control">{$layoutInstructions[$formLocale]|escape}</textarea></div>
			</p>
		</div><!-- layoutInstructionsSection -->

		<div id="layoutTemplates">
			<h4>{translate key="manager.setup.layoutTemplates"}</h4>
			<p class="help-block">{translate key="manager.setup.layoutTemplatesDescription"}</p>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					{foreach name=templates from=$templates key=templateId item=template}
						<tr valign="top">
							<td width="20%"><a href="{url op="downloadLayoutTemplate" path=$templateId}" class="action">{$template.filename|escape}</a></td>
							<td width="50%" class="value">{$template.title|escape}</td>
							<td width="30%"><input type="submit" name="delTemplate[{$templateId|escape}]" value="{translate key="common.delete"}" class="btn btn-danger" /></td>
					{/foreach}
					<tr valign="top">
						<td width="20%">{fieldLabel name="template-title" key="manager.setup.layoutTemplates.title"}</td>
						<td width="80%" colspan="2" class="value"><div class="form-group"><input type="text" name="template-title" id="template-title" size="40" maxlength="90" class="form-control" /></div></td>
					</tr>
					<tr valign="top">
						<td width="20%">{fieldLabel name="template-file" key="manager.setup.layoutTemplates.file"}</td>
						<td width="80%" colspan="2" class="value"><div class="form-group"><input type="file" name="template-file" id="template-file" class="form-control" /></div><input type="submit" name="addTemplate" value="{translate key="common.upload"}" class="btn btn-success" /></td>
					</tr>
				</table>
			</div>
		</div><!-- layoutTemplates -->

		<div id="referenceLinking">
			<h4>{translate key="manager.setup.referenceLinking"}</h4>
			<p class="help-block">{translate key="manager.setup.referenceLinkingDescription"}</p>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td width="5%"><div class="form-group"><input type="checkbox" name="provideRefLinkInstructions" id="provideRefLinkInstructions" value="1"{if $provideRefLinkInstructions} checked="checked"{/if} /></div></td>
						<td width="95%" class="value"><label class="control-label" for="provideRefLinkInstructions">{translate key="manager.setup.provideRefLinkInstructions"}</label></td>
					</tr>
				</table>
			</div>
		</div><!-- referenceLinking -->

		<div id="refLinkInstructionsSection">
			<h4>{translate key="manager.setup.refLinkInstructions.description"}</h4>
			<div class="form-group"><textarea name="refLinkInstructions[{$formLocale|escape}]" id="refLinkInstructions" rows="12" cols="60" class="form-control">{$refLinkInstructions[$formLocale]|escape}</textarea></div>
		</div><!-- refLinkInstructionsSection -->
	</div>
	
	<div class="separator"></div>

	<div id="proofreading" class="col-md-12 mag-innert-left">
		<h3>4.7 {translate key="manager.setup.proofreading"}</h3>
		<p class="help-block">{translate key="manager.setup.selectOne"}:</p>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="5%"><div class="form-group"><input type="radio" name="useProofreaders" id="useProofreaders-1" value="1"{if $useProofreaders} checked="checked"{/if} /></div></td>
					<td width="95%" class="value"><label class="control-label" for="useProofreaders-1">{translate key="manager.setup.useProofreaders"}</label></td>
				</tr>
				<tr valign="top">
					<td width="5%"><div class="form-group"><input type="radio" name="useProofreaders" id="useProofreaders-0" value="0"{if !$useProofreaders} checked="checked"{/if} /></div></td>
					<td width="95%" class="value"><label class="control-label" for="useProofreaders-0">{translate key="manager.setup.noUseProofreaders"}</label></td>
				</tr>
			</table>
		</div>
		
		<div id="proofingInstructions">
			<h4>{translate key="manager.setup.proofingInstructions"}</h4>
			<p class="help-block">{translate key="manager.setup.proofingInstructionsDescription"}</p>

			<p>
				<div class="form-group"><textarea name="proofInstructions[{$formLocale|escape}]" id="proofInstructions" rows="12" cols="60" class="form-control">{$proofInstructions[$formLocale]|escape}</textarea></div>
			</p>
		</div>
	</div>

	<div class="separator"></div>

	<p><input type="submit" value="{translate key="common.saveAndContinue"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="setup" escape=false}'" /></p>

	<p class="help-block">{translate key="common.requiredField"}</p>
</form>

{include file="common/footer.tpl"}