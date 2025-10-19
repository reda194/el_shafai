# RenderFlex Overflow Prevention Checklist

## 🚨 Critical Overflow Prevention Rules

### 1. **Fixed Dimensions → Responsive Dimensions**
- ❌ `width: 200` → ✅ `width: MediaQuery.of(context).size.width * 0.6`
- ❌ `height: 300` → ✅ `height: MediaQuery.of(context).size.height * 0.4`
- ❌ `padding: EdgeInsets.all(20)` → ✅ `padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05)`

### 2. **Hardcoded Text Sizes → Responsive Text**
- ❌ `fontSize: 24` → ✅ Use `ResponsiveText` or `AppResponsiveTextStyles.titleMedium(context)`
- ❌ Long text without overflow handling → ✅ `Text(overflow: TextOverflow.ellipsis, maxLines: 2)`

### 3. **Fixed Grid Columns → Dynamic Columns**
- ❌ `crossAxisCount: 3` → ✅ `crossAxisCount: constraints.maxWidth < 400 ? 2 : 3`

### 4. **Unbounded Widgets → Bounded Widgets**
- ❌ `Container()` → ✅ `Container(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9))`

## 📱 Screen Size Breakpoints

```dart
// Recommended breakpoints for responsive design
const double mobileSmall = 320;
const double mobileLarge = 480;
const double tabletSmall = 600;
const double tabletLarge = 900;
const double desktop = 1200;

// Usage example:
int getGridColumns(double width) {
  if (width < mobileLarge) return 2;
  if (width < tabletSmall) return 3;
  if (width < tabletLarge) return 4;
  return 5;
}
```

## 🔧 Essential Overflow-Safe Widgets

### Use These Instead of Raw Widgets:

1. **ResponsiveContainer** - Instead of Container
2. **ResponsiveText** - Instead of Text
3. **ResponsiveGrid** - Instead of GridView
4. **SafeCard** - Instead of Card/Container for cards
5. **OverflowSafeRow** - Instead of Row (auto-wraps when needed)

### Quick Migration Examples:

```dart
// Before (Overflow prone)
Row(
  children: [
    Container(width: 100, child: Text('Long text here')),
    Container(width: 100, child: Text('Another long text')),
    Container(width: 100, child: Text('More text')),
  ],
)

// After (Overflow safe)
OverflowSafeRow(
  spacing: 8,
  children: [
    Flexible(child: Text('Long text here', overflow: TextOverflow.ellipsis)),
    Flexible(child: Text('Another long text', overflow: TextOverflow.ellipsis)),
    Flexible(child: Text('More text', overflow: TextOverflow.ellipsis)),
  ],
)
```

## 📏 Spacing Guidelines

### Safe Margins and Padding:
- **Horizontal margins**: 16-32px (responsive)
- **Vertical spacing**: 8-24px (responsive)
- **Screen edge padding**: 16-24px (responsive)

### Responsive Spacing Example:
```dart
EdgeInsets.symmetric(
  horizontal: MediaQuery.of(context).size.width * 0.04, // 4% of screen width
  vertical: 16,
).clamp(
  const EdgeInsets.symmetric(horizontal: 16, vertical: 16), // Minimum
  const EdgeInsets.symmetric(horizontal: 32, vertical: 24), // Maximum
)
```

## 🎯 Common Overflow Scenarios & Solutions

### 1. **Text Overflow in Cards**
```dart
// ❌ Problem
Text('Very long Arabic text that will overflow')

// ✅ Solution
Text(
  'Very long Arabic text that will overflow',
  overflow: TextOverflow.ellipsis,
  maxLines: 2,
  style: TextStyle(fontSize: context.responsiveFontSize(14)),
)
```

### 2. **Horizontal List Overflow**
```dart
// ❌ Problem
ListView(
  scrollDirection: Axis.horizontal,
  children: List.generate(10, (i) => Container(width: 200)), // Fixed width
)

// ✅ Solution
SizedBox(
  height: 200,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 10,
    itemBuilder: (context, index) => Container(
      width: MediaQuery.of(context).size.width * 0.6,
      constraints: BoxConstraints(minWidth: 160, maxWidth: 220),
      margin: const EdgeInsets.only(right: 16),
    ),
  ),
)
```

### 3. **Grid Overflow on Small Screens**
```dart
// ❌ Problem
GridView.count(crossAxisCount: 4) // Too many columns on small screens

// ✅ Solution
ResponsiveGrid(
  minCrossAxisCount: 2,
  maxCrossAxisCount: 4,
  children: items,
)
```

### 4. **Button Text Overflow**
```dart
// ❌ Problem
ElevatedButton(
  child: Text('Very long button text'),
)

// ✅ Solution
ElevatedButton(
  child: ResponsiveText(
    'Very long button text',
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  ),
)
```

## 🧪 Testing Checklist

### For Each Screen:
- [ ] Test on 320px width device (iPhone SE)
- [ ] Test on 390px width device (iPhone 12/13/14)
- [ ] Test on 428px width device (iPhone 12/13/14 Pro Max)
- [ ] Test on tablet (768px+ width)
- [ ] Test with system font scaling enabled
- [ ] Test with Arabic text of varying lengths
- [ ] Test with keyboard visible (if applicable)

### Automated Checks:
- [ ] No fixed widths > 300px without responsive alternatives
- [ ] No text without overflow handling
- [ ] No grids with fixed crossAxisCount > 3
- [ ] All containers have reasonable maxWidth constraints

## 🔍 Debugging Overflow Issues

### When You See Yellow/Black Stripes:

1. **Check Layout Inspector** - Use Flutter DevTools to identify the overflowing widget
2. **Use Debug Painting** - Add `debugPaintSizeEnabled = true` to see widget boundaries
3. **Check Constraints** - Print `constraints` in LayoutBuilder to understand available space
4. **Test on Different Sizes** - Use Device Preview package to test various screen sizes

### Quick Debug Code:
```dart
LayoutBuilder(
  builder: (context, constraints) {
    print('Available width: ${constraints.maxWidth}');
    print('Available height: ${constraints.maxHeight}');
    return YourWidget();
  },
)
```

## 🚀 Performance Considerations

### Avoid:
- Deep nesting of LayoutBuilder widgets
- Unnecessary MediaQuery calls in build methods
- Complex calculations in every build

### Prefer:
- Pre-calculated responsive values
- Memoization of responsive calculations
- Extension methods for common responsive operations

## 📚 Best Practices Summary

1. **Always use LayoutBuilder** for responsive layouts
2. **Never use fixed dimensions** without constraints
3. **Always handle text overflow** with ellipsis or fade
4. **Test on multiple screen sizes** before release
5. **Use the provided utility widgets** instead of raw Flutter widgets
6. **Set reasonable min/max constraints** on flexible widgets
7. **Consider keyboard appearance** in forms and input screens

## 🛠️ Quick Fixes for Common Issues

### Issue: "Right overflowed by X pixels"
**Solution**: Wrap in SingleChildScrollView or make width responsive

### Issue: "A RenderFlex overflowed by X pixels on the bottom"
**Solution**: Use Flexible/Expanded widgets or add scrolling

### Issue: Text is cut off
**Solution**: Add maxLines and overflow properties to Text widgets

### Issue: Grid looks bad on small screens
**Solution**: Use ResponsiveGrid with dynamic crossAxisCount

Remember: Prevention is better than cure. Use these utilities from the start to avoid overflow issues entirely!
