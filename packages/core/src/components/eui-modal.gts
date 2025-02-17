import { hash } from '@ember/helper';
import { on } from '@ember/modifier';

import optional from '@nullvoxpopuli/ember-composable-helpers/helpers/optional';
import preventDefault from 'ember-event-helpers/helpers/prevent-default';
import stopPropagation from 'ember-event-helpers/helpers/stop-propagation';
import { focusTrap } from 'ember-focus-trap';
import onKey from 'ember-keyboard/modifiers/on-key';
import style from 'ember-style-modifier/modifiers/style';
import { and, eq, notEq } from 'ember-truth-helpers';

import argOrDefault from '../helpers/arg-or-default.ts';
import classNames from '../helpers/class-names.ts';
import inlineStyles from '../helpers/inline-styles.ts';
import EuiButtonIcon from './eui-button-icon.gts';
import EuiOverlayMask from './eui-overlay-mask.gts';

import type { TemplateOnlyComponent } from '@ember/component/template-only';

export interface EuiModalSignature {
  Element: HTMLDivElement;
  Args: {
    onClose?: (e: Event) => void;
    maxWidth?: boolean | string;
    clickOutsideToClose?: boolean;
    isFocusTrapActive?: boolean;
    shouldSelfFocus?: boolean;
    isFocusTrapPaused?: boolean;
    focusTrapOptions?: {
      allowOutsideClick?: boolean;
      clickOutsideDeactivates?: boolean;
      initialFocus?: string | HTMLElement | (() => HTMLElement);
      fallbackFocus?: string | HTMLElement | (() => HTMLElement);
      escapeDeactivates?: boolean;
      returnFocusOnDeactivate?: boolean;
      preventScroll?: boolean;
    };
  };
  Blocks: {
    default: [];
  };
}

const EuiModal: TemplateOnlyComponent<EuiModalSignature> = <template>
  {{#let
    (if
      (and @maxWidth (notEq @maxWidth true))
      (inlineStyles
        componentName="EuiModal" componentArgs=(hash maxWidth=@maxWidth)
      )
      (hash)
    )
    as |inlineStyles|
  }}
    <EuiOverlayMask
      @onClick={{if @clickOutsideToClose (optional @onClose) (optional)}}
    >
      <div
        class={{classNames
          "euiModal"
          (if (eq @maxWidth true) "euiModal--maxWidth-default")
        }}
        tabindex="0"
        ...attributes
        {{style inlineStyles}}
        {{focusTrap
          isActive=(argOrDefault @isFocusTrapActive true)
          shouldSelfFocus=(argOrDefault @shouldSelfFocus true)
          isPaused=(argOrDefault @isFocusTrapPaused false)
          focusTrapOptions=(argOrDefault @focusTrapOptions (hash))
        }}
        {{onKey
          "Escape"
          (preventDefault (stopPropagation (optional @onClose)))
        }}
      >
        <EuiButtonIcon
          class="euiModal__closeIcon"
          @iconType="cross"
          @color="text"
          {{on "click" (optional @onClose)}}
        />
        <div class="euiModal__flex">
          {{yield}}
        </div>
      </div>
    </EuiOverlayMask>
  {{/let}}
</template>;

export default EuiModal;
