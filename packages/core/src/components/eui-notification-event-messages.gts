import { concat } from '@ember/helper';

import randomId from '../-private/random-id.ts';
import EuiAccordion from './eui-accordion.gts';
import EuiText from './eui-text.gts';

import type { TemplateOnlyComponent } from '@ember/component/template-only';

const objectAt = <T,>(pos: number, array: T[]) => array[pos];
const without = <T,>(obj: T, array: T[]) => {
  return array.filter((item) => item !== obj);
};

export interface EuiNotificationEventMessagesSignature {
  Element: HTMLDivElement;
  Args: {
    messages: string[];
    accordionButtonText?: string;
    accordionHideText?: string;
    accordionAriaLabelButtonText?: string;
  };
}

const EuiNotificationEventMessages: TemplateOnlyComponent<EuiNotificationEventMessagesSignature> =
  <template>
    <div class="euiNotificationEventMessages" ...attributes>
      {{#let
        (objectAt 0 @messages) (without (objectAt 0 @messages) @messages)
        as |first rest|
      }}

        {{#if first}}
          <EuiText @size="s" @color="subdued">
            <p>{{first}}</p>
          </EuiText>
        {{/if}}

        {{#if rest}}

          <EuiAccordion
            id={{concat "euiNotificationEventMessagesAccordion" (randomId)}}
            class="euiNotificationEventMessages__accordion"
            @buttonClassName="euiNotificationEventMessages__accordionButton"
            @arrowDisplay="none"
          >
            <:buttonContent as |isOpen|>
              {{@accordionButtonText}}
              {{#unless isOpen}}
                ({{@accordionHideText}})
              {{/unless}}
            </:buttonContent>

            <:content>
              <div class="euiNotificationEventMessages__accordionContent">
                {{#each rest as |msg|}}
                  <EuiText @size="s" @color="subdued">
                    <p>{{msg}}</p>
                  </EuiText>
                {{/each}}
              </div>
            </:content>

          </EuiAccordion>
        {{/if}}

      {{/let}}
    </div>
  </template>;

export default EuiNotificationEventMessages;
