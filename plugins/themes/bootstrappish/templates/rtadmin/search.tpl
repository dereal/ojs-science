{**
 * templates/rtadmin/search.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * RTAdmin search editing
 *
 *}
{strip}
{assign var="pageTitle" value="rt.admin.searches.edit.editSearch"}
{include file="common/header.tpl"}
{/strip}

<form role="form" action="{if $searchId}{url op="saveSearch" path=$versionId|to_array:$contextId:$searchId}{else}{url op="createSearch" path=$versionId|to_array:$contextId:"save"}{/if}" method="post">
	<div class="table-responsive">
		<table class="table table-striped" width="100%">
			<tr valign="top">
				<td width="20%"><label class="control-label" for="title">{translate key="rt.search.title"}</label></td>
				<td class="value" width="80%"><div class="form-group"><input type="text" class="form-control" name="title" id="title" value="{$title|escape}" size="60" /></div></td>
			</tr>
			<tr valign="top">
				<td><label class="control-label" for="url">{translate key="rt.search.url"}</label></td>
				<td class="value"><div class="form-group"><input type="text" class="form-control" name="url" id="url" value="{$url|escape}" size="60" /></div></td>
			</tr>
			<tr valign="top">
				<td><label class="control-label" for="searchUrl">{translate key="rt.search.searchUrl"}</label></td>
				<td class="value"><div class="form-group"><input type="text" class="form-control" name="searchUrl" id="searchUrl" value="{$searchUrl|escape}" size="60" /></div></td>
			</tr>
			<tr valign="top">
				<td><label class="control-label" for="searchPost">{translate key="rt.search.searchPost"}</label></td>
				<td class="value"><div class="form-group"><input type="text" class="form-control" name="searchPost" id="searchPost" value="{$searchPost|escape}" size="60" /></div></td>
			</tr>
			<tr valign="top">
				<td><label class="control-label" for="description">{translate key="rt.context.description"}</label></td>
				<td class="value">
					<div class="form-group"><textarea class="form-control" name="description" id="description" rows="5" cols="60">{$description|escape}</textarea></div>
				</td>
			</tr>
		</table>
	</div>

	<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="searches" path=$versionId|to_array:$contextId escape=false}'" /></p>
</form>

{include file="common/footer.tpl"}