import { helper } from '@ember/component/helper';
import { assert } from '@ember/debug';

// Mappings registry
import cssMappings from '../utils/css-mappings';

interface Options {
  size: string;
  padding: string;
};

/**
 * Joins a list of classes
 *
 * @param classes - List of classes that will be joined
 */
export function classNames([componentName, ...classNames]: string[] = [], { size, padding }: Options): string {
  assert('The component name must be provided as the first parameter', componentName !== undefined);
  assert(`The component '${componentName}' doesn't have mappings defined`, cssMappings[componentName] !== undefined);

  let classes: string[] = [...classNames];

  classes.push(cssMappings[componentName].base || '');
  classes.push(cssMappings[componentName].properties.size?.[size] || '');
  classes.push(cssMappings[componentName].properties.padding?.[padding] || '');

  return classes.join(' ');
}

export default helper(classNames);
