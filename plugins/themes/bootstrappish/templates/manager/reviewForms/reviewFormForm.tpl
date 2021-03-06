{**
 * templates/manager/reviewForms/reviewFormForm.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to create/modify a review form.
 *
 *}
{strip}
{include file="common/header.tpl"}
{/strip}

{if $reviewFormId}
	<ul class="stay">
		<li class="current"><a href="{url op="editReviewForm" path=$reviewFormId}">{translate key="manager.reviewForms.edit"}</a></li>
		<li><a href="{url op="reviewFormElements" path=$reviewFormId}">{translate key="manager.reviewFormElements"}</a></li>
		<li><a href="{url op="previewReviewForm" path=$reviewFormId}">{translate key="manager.reviewForms.preview"}</a></li>
	</ul>
{/if}

<br/>

<form role="form" id="reviewFormForm" method="post" action="{url op="updateReviewForm"}">
	{if $reviewFormId}
		<input type="hidden" name="reviewFormId" value="{$reviewFormId}"/>
	{/if}

	{include file="common/formErrors.tpl"}

	<div class="table-responsive">
		<table class="table table-striped" width="100%">
			{if count($formLocales) > 1}
				<tr valign="top">
					<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td width="80%" class="value">
						{if $reviewFormId}{url|assign:"reviewFormFormUrl" op="editReviewForm" path=$reviewFormId escape=false}
						{else}{url|assign:"reviewFormFormUrl" op="createReviewForm" escape=false}
						{/if}
						{form_language_chooser form="reviewFormForm" url=$reviewFormFormUrl}
						<p class="help-block">{translate key="form.formLanguage.description"}</p>
					</td>
				</tr>
			{/if}
			<tr valign="top">
				<td width="20%">{fieldLabel name="title" required="true" key="manager.reviewForms.title"}</td>
				<td width="80%" class="value"><div class="form-group"><input type="text" name="title[{$formLocale|escape}]" value="{$title[$formLocale]|escape}" id="title" size="40" maxlength="120" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="description" key="manager.reviewForms.description"}</td>
				<td class="value"><div class="form-group"><textarea name="description[{$formLocale|escape}]" rows="4" cols="40" id="description" class="form-control">{$description[$formLocale]|escape}</textarea></div></td>
			</tr>
		</table>
	</div>

	<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="reviewForms" escape=false}'" /></p>
</form>

<p class="help-block">{translate key="common.requiredField"}</p>

{include file="common/footer.tpl"}