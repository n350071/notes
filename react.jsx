// material-ui/TextField/EnhancedTextareaのmultiLine={true}のときのバグ対応
// 現象：react-test-rendererの renderer.createにてエラーが発生してしまう
// TypeError: Cannot set property 'value' of undefined
// <1> : プロダクトコードをこうする
const isTest = process.env.NODE_ENV === 'test' ? true : false
// <2> ：Jestをこうする
jest.mock('material-ui/TextField/EnhancedTextarea');
