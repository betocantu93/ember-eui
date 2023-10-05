---
order: 1
---

<EuiText>
  <p>
    <strong>EuiComboBox </strong> ember's implementation uses <a href="https://ember-power-select.com">ember-power-select</a> under the hood for a rich selector, so please refer to it if needed.
  </p>
</EuiText>

```hbs template
<EuiAutoRefresh
      @isPaused={{this.isPaused}}
      @refreshInterval={{this.refreshInterval}}
      @onRefreshChange={{this.onRefreshChange}}
    />
```

```javascript component
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';

export default class extends Component {
  @tracked isPaused = true;
  @tracked refreshInterval = 1000;
  
	onRefreshChange = ({ isPaused, refreshInterval}) => {
		this.isPaused = isPaused;
		this.refreshInterval = refreshInterval;
	}
}
```
