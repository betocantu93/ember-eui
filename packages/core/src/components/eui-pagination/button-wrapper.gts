import { fn } from '@ember/helper';
import { on } from '@ember/modifier';

import { eq } from 'ember-truth-helpers';

import argOrDefault from '../../helpers/arg-or-default.ts';
import EuiPaginationButton from '../eui-pagination-button.gts';

import type { TemplateOnlyComponent } from '@ember/component/template-only';

export interface EuiPaginationButtonWrapperSignature {
  Args: {
    inList?: boolean;
    pageIndex: number;
    props: {
      pageCount?: number;
      activePage?: number;
      ariaControls?: string;
      safeClick: (page: number) => void;
    };
  };
}

const ButtonWrapper: TemplateOnlyComponent<EuiPaginationButtonWrapperSignature> =
  <template>
    {{#if (argOrDefault @inList true)}}
      <li>
        <EuiPaginationButton
          @isActive={{eq @pageIndex @props.activePage}}
          @totalPages={{@props.pageCount}}
          @pageIndex={{@pageIndex}}
          aria-controls={{@props.ariaControls}}
          @hideOnMobile={{true}}
          {{on "click" (fn @props.safeClick @pageIndex)}}
        />
      </li>
    {{else}}
      <EuiPaginationButton
        @isActive={{eq @pageIndex @props.activePage}}
        @totalPages={{@props.pageCount}}
        @pageIndex={{@pageIndex}}
        aria-controls={{@props.ariaControls}}
        @hideOnMobile={{true}}
        {{on "click" (fn @props.safeClick @pageIndex)}}
      />
    {{/if}}
  </template>;

export default ButtonWrapper;
