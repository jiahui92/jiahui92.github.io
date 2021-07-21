---
title: 语法
toc: true
date: 2020-11-15 00:00:03
tags:
---

# TODO
* TS的内置基础类型: Omit之类的【[参考资料](https://juejin.cn/post/6844904066489778183)】
  

# 基础类型关键字
* number, string, boolean
* any, void, never ( null, undefined )

# 语法
```typescript
export interface ISomeProps {
  message?: string,
  readonly type: string.

  onClose: () => void,
  getContainer: () => HTMLElement,
}

const arr: number[] = [1, 2];
const arr: Array<number|string> = [1, 2, '3'];

function hello(): void {}
```

## 泛型
```typescript
// 注册一个泛型变量T来表示用户的输入
function log<T>(a: T): T[] {
  return [a];
}
```

```typescript
// 一个稍微复杂的例子 https://github.com/ant-design/ant-design/blob/master/components/select/index.tsx#L35

type SelectValue = '0' | '1';
interface InternalSelectProps<VT> {}

interface SelectProps<VT>
  extends Omit<
    InternamSelectProps<VT>,
    'inputIcon' | 'mode' | 'xxx'
  > {
    mode?: 'multiple' | 'tags'
}

class Select<ValueType extends SelectValue>
  extends React.Component<SelectProps<ValueType>>
{}
```

## 高级
### & 和 |
```typescript
function a (a: number | string) {} 

interface A { a: number, c: number }
interface B { b: number, c: number }
type D1 = A & B; // { a, b, c }
type D2 = A | B; // { a?, b?, c }
```

### keyof
返回Object的key
```typescript
interface Person {
    name: string;
    age: number;
}

// 'name' | 'age'
keyof Person;
```

### k in key
遍历集合
```typescript
type Keys = 'a' | 'b';
// { a: boolean, b: boolean }
type Flags = { [K in Keys]: boolean };

// // { a?: boolean, b?: boolean }
type PartialFlags = {
  [P in keyof Flags]?: Flags[P]
}
```

### extends
```typescript
// K是name或age
K extends 'name' | 'age'
// 三目运算
T extends U ? X : Y
'a' extends 'a' | 'b' // true

type Exclude<T, U> = T extends U ? never : T;
// 'b' | 'c'
Exclude<'a' | 'b' | 'c', 'a' | 'd'>;
```
```typescript
let person: Person = {
  name: 'Jarid',
  age: 35
};

function pluck<T, K extends keyof T>(o: T, names: K[]): T[K][] {
  return names.map(n => o[n]);
}
let strings: string[] = pluck(person, ['name']); // ok, string[]
```

### 内置函数
* Record
```typescript
interface Person {
  name: string;
  age: number;
  gender: string;
}

// 使用
// { name?, age?, gender? }
type PartialPerson = Partial<Person>; 
// { readonly name, readonly age, readonly gender }
type ReadonlyPerson = Readonly<Person>;
// { name, age }
type PickPerson = Pick<Person, 'name' | 'age'>;
// { gender }
type OmitPerson = Omit<Person, 'name' | 'age'>

// 'name' | 'age' | 'gender'
keyof Person
// { name, age }
Exclude<keyof Person, 'gender'>;
// { gender }
Extract<keyof Person, 'gender'>;

// { a: Person; b: Person; c: Person; }
Record<'a' | 'b' | 'c', Person>;


// string | number
NonNullable<string | number | undefined>;
// string
ReturnType<() => string>;
// T
ReturnType<<T>() => T>;
```

```typescript
// 原理
type Readonly<T> = {
  readonly [P in keyof T]: T[P];
}

type Partial<T> = {
  [P in keyof T]?: T[P];
}

type Omit<T, K extends keyof any> = Pick<T, Exclude<keyof T, K>>;
```

### TODO 同态
* 类似于引用的类型，改了底层，全部都被改掉？
* Readonly， Partial和 Pick是同态的，但 Record不是。 因为 Record并不需要输入类型来拷贝属性，所以它不属于同态：
* 非同态类型本质上会创建新的属性，因此它们不会从它处拷贝属性修饰符。


# 问题
## TODO type和interface的区别
一般直接用interface
[参考资料](https://juejin.im/post/6844903749501059085)
* TODO