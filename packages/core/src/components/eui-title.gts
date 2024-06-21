import argOrDefault from '../helpers/arg-or-default.ts';
import classNames from '../helpers/class-names.ts';
import TextBlock from './text-block.gts';

import type { sizeMapping, transformMapping } from '../utils/css-mappings/eui-title.ts';
import type { TextBlockSignature } from './text-block';
import type { TemplateOnlyComponent } from '@ember/component/template-only';

export interface EuiTitleSignature {
  Element: HTMLHeadingElement;
  Args: {
    tagName?: TextBlockSignature['Args']['tagName'];
    size?: keyof typeof sizeMapping;
    textTransform?: keyof typeof transformMapping;
  };
  Blocks: {
    default: [];
  };
}

const EuiTitle: TemplateOnlyComponent<EuiTitleSignature> = <template>
  <TextBlock
    @tagName={{argOrDefault @tagName "h2"}}
    class={{classNames
      componentName="EuiTitle"
      size=(argOrDefault @size "m")
      textTransform=@textTransform
    }}
    ...attributes
  >
    {{yield}}
  </TextBlock>
</template>;

export default EuiTitle;
