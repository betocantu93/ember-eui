import { concat } from '@ember/helper';

import { eq } from 'ember-truth-helpers';

import randomId from '../-private/random-id.ts';
import argOrDefault from '../helpers/arg-or-default.ts';
import classNames from '../helpers/class-names.ts';
import EuiCheckbox from './eui-checkbox.gts';
import EuiRadio from './eui-radio.gts';

import type { EuiCheckboxSignature } from './eui-checkbox';
import type { EuiRadioSignature } from './eui-radio';
import type { TemplateOnlyComponent } from '@ember/component/template-only';

export interface EuiCheckableCardSignature {
  Element: EuiCheckboxSignature['Element'] | EuiRadioSignature['Element'];
  Args: {
    id?: string;
    label?: string;
    checked?: boolean;
    disabled?: boolean;
    checkableType?: 'checkbox' | 'radio';
  };
  Blocks: {
    default: [];
    label: [];
    content: [];
  };
}

const EuiCheckableCard: TemplateOnlyComponent<EuiCheckableCardSignature> =
  <template>
    {{#let (argOrDefault @id (randomId)) as |id|}}
      <div
        class={{classNames
          "euiPanel euiPanel--borderRadiusMedium euiPanel--plain euiPanel--hasShadow euiPanel--hasBorder euiPanel--flexGrowZero euiSplitPanel euiSplitPanel--row euiCheckableCard"
          (if @checked "euiCheckableCard-isChecked")
          (if @disabled "euiCheckableCard__label-isDisabled")
        }}
      >
        <div
          class={{classNames
            "euiPanel euiPanel--paddingMedium euiPanel--borderRadiusNone euiPanel--subdued euiPanel--noShadow euiPanel--noBorder euiPanel--flexGrowZero euiPanel--isClickable euiSplitPanel__inner"
            (if @checked "euiPanel--primary")
          }}
        >
          {{#if (eq @checkableType "checkbox")}}
            <EuiCheckbox
              @id={{id}}
              @checked={{@checked}}
              disabled={{@disabled}}
              ...attributes
            />
          {{else}}
            <EuiRadio
              @id={{id}}
              @checked={{@checked}}
              disabled={{@disabled}}
              ...attributes
            />
          {{/if}}
        </div>
        <div
          class="euiPanel euiPanel--paddingMedium euiPanel--borderRadiusNone euiPanel--transparent euiPanel--noShadow euiPanel--noBorder euiSplitPanel__inner"
        >
          <label
            class={{classNames
              "euiCheckableCard__label"
              (if @disabled "euiCheckableCard__label-isDisabled")
            }}
            for={{id}}
            aria-describedby={{if (has-block "content") (concat id "-details")}}
          >
            {{#if (has-block "label")}}
              {{yield to="label"}}
            {{else}}
              {{@label}}
            {{/if}}
          </label>

          {{#if (has-block "content")}}

            {{! Empty div for left side background color only }}

            <div id={{concat id "-details"}} class="euiCheckableCard__children">
              {{yield to="content"}}
            </div>

          {{/if}}

        </div>
      </div>
    {{/let}}
  </template>;

export default EuiCheckableCard;
