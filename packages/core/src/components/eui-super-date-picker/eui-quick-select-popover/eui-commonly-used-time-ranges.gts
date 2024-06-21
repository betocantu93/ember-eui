import { fn,hash } from '@ember/helper';
import { on } from '@ember/modifier';

import randomId from '../../../-private/random-id.ts';
import EuiFlexGrid from '../../eui-flex-grid.gts';
import EuiFlexItem from '../../eui-flex-item.gts';
import EuiI18n from '../../eui-i18n.gts';
import EuiLink from '../../eui-link.gts';
import EuiTitle from '../../eui-title.gts';

import type {
  DurationRange
} from '../types/global';
import type { TemplateOnlyComponent } from '@ember/component/template-only';

export interface EuiCommonlyUsedTimeRangesSignature {
  Args: {
    applyTime: (args: { start: string; end: string }) => void;
    commonlyUsedRanges: DurationRange[];
  };
}

const EuiCommonlyUsedTimeRanges: TemplateOnlyComponent<EuiCommonlyUsedTimeRangesSignature> =
  <template>
    {{#let (randomId) as |legendId|}}
      <fieldset>
        <EuiTitle id={{legendId}} @tagName="legend" @size="xxxs">
          <EuiI18n
            @token="euiCommonlyUsedTimeRanges.legend"
            @default="Commonly used"
            as |Token|
          >
            <Token as |value|>
              {{value}}
            </Token>
          </EuiI18n>
        </EuiTitle>
        <div class="euiQuickSelectPopover__section">
          <EuiFlexGrid
            aria-labelledby={{legendId}}
            @gutterSize="s"
            @columns={{2}}
            @direction="column"
            @responsive={{false}}
            @tagName="ul"
          >
            {{#each @commonlyUsedRanges as |range|}}
              <EuiFlexItem
                class="euiQuickSelectPopover__sectionItem"
                @tagName="li"
              >
                <EuiLink
                  {{on
                    "click"
                    (fn @applyTime (hash start=range.start end=range.end))
                  }}
                >
                  {{range.label}}
                </EuiLink>
              </EuiFlexItem>
            {{/each}}
          </EuiFlexGrid>
        </div>
      </fieldset>
    {{/let}}
  </template>;

export default EuiCommonlyUsedTimeRanges;
