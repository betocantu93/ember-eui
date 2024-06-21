import { hash } from '@ember/helper';

import add from 'ember-math-helpers/helpers/add';
import { or } from 'ember-truth-helpers';

import classNames from '../helpers/class-names.ts';
import EuiButtonEmpty from './eui-button-empty.gts';
import EuiI18n from './eui-i18n.gts';

import type { paddingMapping } from '../utils/css-mappings/eui-popover-footer.ts';
import type { EuiButtonEmptySignature } from './eui-button-empty';
import type { TemplateOnlyComponent } from '@ember/component/template-only';

export interface EuiPaginationButtonSignature {
  Element: EuiButtonEmptySignature['Element'];
  Args: {
    paddingSize?: keyof typeof paddingMapping;
    pageIndex?: number;
    totalPages?: number;
    isActive?: boolean;
    isPlaceholder?: boolean;
    hideOnMobile?: boolean;
  };
  Blocks: {
    default: [];
  };
}

const EuiPaginationButton: TemplateOnlyComponent<EuiPaginationButtonSignature> =
  <template>
    {{#let (add @pageIndex 1) as |pageNumber|}}
      <EuiI18n
        @token="euiPaginationButton.longPageString"
        @default="Page {page} of {totalPages}"
        @values={{hash page=pageNumber totalPages=@totalPages}}
        as |Token|
      >
        <Token as |longPageString|>
          <EuiI18n
            @token="euiPaginationButton.shortPageString"
            @default="Page {page}"
            @values={{hash page=pageNumber}}
            as |InnerToken|
          >
            <InnerToken as |shortPageString|>
              <EuiButtonEmpty
                class={{classNames
                  "euiPaginationButton"
                  (if @isActive "euiPaginationButton-isActive")
                  (if @isPlaceholder "euiPaginationButton-isPlaceholder")
                  (if @hideOnMobile "euiPaginationButton--hideOnMobile")
                }}
                aria-label={{if @totalPages longPageString shortPageString}}
                @size="s"
                @color="text"
                @isDisabled={{or @isPlaceholder @isActive}}
                aria-current={{if @isActive true}}
                ...attributes
              >
                {{pageNumber}}
              </EuiButtonEmpty>
            </InnerToken>
          </EuiI18n>
        </Token>
      </EuiI18n>
    {{/let}}
  </template>;

export default EuiPaginationButton;
