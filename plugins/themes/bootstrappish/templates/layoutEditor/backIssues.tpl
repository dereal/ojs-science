{**
 * templates/layoutEditor/backIssues.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Listings of back issues
 *
 *}
{assign var="pageTitle" value="editor.issues.backIssues"}
{url|assign:"currentUrl" page="editor" op="backIssues"}{include file="common/header.tpl"}

<ul class="stay">
    <li><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
    <li class="current"><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
</ul>

<br/>

<a name="issues"></a>

<div class="table-responsive">
	<table width="100%" class="table table-striped">
		<tr>
			<td colspan="5" class="headseparator">&nbsp;</td>
		</tr>
		<tr class="heading" valign="bottom">
			<td width="70%"><label>{translate key="issue.issue"}</label></td>
			<td width="15%"><label>{translate key="editor.issues.published"}</label></td>
			<td width="15%"><label>{translate key="editor.issues.numArticles"}</label></td>
		</tr>
		<tr>
			<td colspan="5" class="headseparator">&nbsp;</td>
		</tr>

		{assign var=pos value=1}
		{iterate from=issues item=issue}
			<tr valign="top">
				<td><a href="{url op="issueToc" path=$issue->getId()}" class="action">{$issue->getIssueIdentification()|escape}</a></td>
				<td>{$issue->getDatePublished()|date_format:"$dateFormatShort"|default:"&mdash;"}</td>
				<td>{$issue->getNumArticles()|escape}</td>
			</tr>
			<tr>
				<td colspan="5" class="{if $issues->eof()}end{/if}separator">&nbsp;</td>
			</tr>
			{assign var=pos value=$pos+1}
		{/iterate}
		{if $issues->wasEmpty()}
			<tr>
				<td colspan="5" class="nodata"><p class="help-block">{translate key="issue.noIssues"}</p></td>
			</tr>
			<tr>
				<td colspan="5" class="endseparator">&nbsp;</td>
			</tr>
		{else}
			<tr>
				<td colspan="2" align="left">{page_info iterator=$issues}</td>
				<td colspan="3" align="right">{page_links anchor="issues" name="issues" iterator=$issues}</td>
			</tr>
		{/if}
	</table>
</div>

{include file="common/footer.tpl"}