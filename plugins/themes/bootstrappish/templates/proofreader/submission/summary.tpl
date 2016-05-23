{**
 * templates/proofreader/submission/summary.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the proofreader's submission summary table.
 *
 *}

<div id="submission" class="col-md-12 mag-innert-left">
	<h3>{translate key="article.submission"}</h3>
	<div class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr>
				<td width="20%">{translate key="article.authors"}</td>
				<td width="80%">
					{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$submission->getAuthorEmails() subject=$submission->getLocalizedTitle() articleId=$submission->getId()}
					{$submission->getAuthorString()|escape} {icon name="mail" url=$url}
				</td>
			</tr>
			<tr>
				<td>{translate key="article.title"}</td>
				<td>{$submission->getLocalizedTitle()|strip_unsafe_html}</td>
			</tr>
			<tr>
				<td>{translate key="section.section"}</td>
				<td>{$submission->getSectionTitle()|escape}</td>
			</tr>
			<tr>
				<td>{translate key="user.role.editor"}</td>
				<td>
					{assign var=editAssignments value=$submission->getEditAssignments()}
					{foreach from=$editAssignments item=editAssignment}
						{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
						{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl subject=$submission->getLocalizedTitle()|strip_tags articleId=$submission->getId()}
						{$editAssignment->getEditorFullName()|escape} {icon name="mail" url=$url}
						{if !$editAssignment->getCanEdit() || !$editAssignment->getCanReview()}
							{if $editAssignment->getCanEdit()}
								({translate key="submission.editing"})
							{else}
								({translate key="submission.review"})
							{/if}
						{/if}
						<br />
					{foreachelse}
						{translate key="common.noneAssigned"}
					{/foreach}
				</td>
			</tr>
		</table>
	</div>
</div>