---
order: 4
---

# Centered Body

<EuiSpacer />
<EuiText>
  When the content for the page is minimal or in an empty/pre-setup state, the page content can be centered vertically and horizontally. We recommend then using the <strong>EuiEmptyPrompt</strong> for the content.
</EuiText>
<EuiSpacer />
<EuiCallOut>
  <:title>
    This layout can be achieved in <strong>EuiPageTemplate</strong> by setting <EuiCode>template="centeredBody"</EuiCode>.
  </:title>
</EuiCallOut>

```hbs template
<EuiPageTemplate
  @template='centeredBody'
  @grow={{true}}
  @pageSideBar={{component 'eui-loading-content' lines=8}}
>
  <EuiEmptyPrompt @paddingSize='l'>
    <:content>
      <EuiTitle>No spice</EuiTitle>
      <EuiSpacer />
      <EuiLoadingContent @lines={{8}} />
      <EuiButton>
        Go to full screen
      </EuiButton>
    </:content>
    <:footer>
      Footer
    </:footer>
  </EuiEmptyPrompt>
</EuiPageTemplate>
```