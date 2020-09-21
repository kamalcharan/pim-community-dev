import React, {ReactElement, Children, cloneElement} from 'react';
import {BreadcrumbItemProps as ItemProps} from './BreadcrumbItem';

interface Props {
    children: ReactElement<ItemProps> | Array<ReactElement<ItemProps>>;
}

const Breadcrumb = ({children}: Props) => {
    const count = Children.count(children);

    return (
        <div className='AknBreadcrumb'>
            {Children.map(children, (item, index) => {
                const isLast = item.props.isLast === undefined ? index === count - 1 : item.props.isLast;

                return cloneElement(item, {isLast});
            })}
        </div>
    );
};

export {Breadcrumb};
