# TESTING STANDARDS - ALL AGENTS MANDATORY

**EVERY AGENT MUST FOLLOW THESE TESTING STANDARDS**

## **🧪 REQUIRED TEST TYPES**

### **1. UNIT TESTS**
- **Every function** gets unit tests
- **Every component** gets component tests  
- **Every utility** gets isolated testing
- **Edge cases** and error conditions covered
- **Minimum 90% code coverage**

### **2. INTEGRATION TESTS**
- **API endpoints** to UI component flows
- **Hook integration** with components
- **Data transformation** pipelines
- **Cross-component** communication
- **State management** integration

### **3. SYSTEM TESTS**
- **End-to-end workflows** with real data
- **Cross-browser compatibility** 
- **Mobile responsiveness**
- **Performance under load**
- **Error recovery scenarios**

### **4. VISUAL VERIFICATION**
- **Screenshot testing** before/after changes
- **Manual browser verification** required
- **UI regression prevention**
- **Accessibility compliance**
- **Design system adherence**

## **🚨 COMPLETION CRITERIA**

**NO TASK IS COMPLETE WITHOUT:**
- [ ] All tests written and passing
- [ ] Visual verification with screenshots/browser testing
- [ ] Real data tested (not just mocks)
- [ ] Edge cases covered
- [ ] Documentation updated
- [ ] Code reviewed (self-review minimum)

## **⚠️ FORBIDDEN PRACTICES**

❌ **Declaring completion without visual verification**
❌ **Skipping tests due to time pressure**  
❌ **Using only mock data for testing**
❌ **Assuming code works without running it**
❌ **False completion reports**

## **✅ REQUIRED EVIDENCE**

**Every completion report must include:**
1. **Test Results**: All tests passing with coverage report
2. **Visual Evidence**: Screenshots showing working functionality
3. **Real Data**: Evidence of testing with actual API data
4. **Browser Testing**: Confirmation across different browsers
5. **Mobile Testing**: Responsive design verification

## **🎯 EXAMPLES OF GOOD TESTING**

### **For UI Components:**
```typescript
// Unit test
test('CostDisplay shows correct currency format', () => {
  render(<CostDisplay amount={1.234} />);
  expect(screen.getByText('$1.23')).toBeInTheDocument();
});

// Integration test  
test('TaskCard displays running cost from API', async () => {
  mockApiResponse({ estimatedCost: 2.50 });
  render(<TaskCard taskId="123" />);
  await waitFor(() => {
    expect(screen.getByText('$2.50 (running)')).toBeInTheDocument();
  });
});

// Visual verification
// Screenshot: task-card-with-running-cost.png
// Browser test: Manually verified in Chrome, Safari, Firefox
```

### **For API Endpoints:**
```typescript
// Unit test
test('calculateTaskCost returns correct value', () => {
  const result = calculateTaskCost(tokens: 1000, model: 'gpt-4');
  expect(result).toBe(0.03);
});

// Integration test
test('POST /api/tasks includes cost calculation', async () => {
  const response = await request(app)
    .post('/api/tasks')
    .send({ taskData });
  expect(response.body.cost).toBeGreaterThan(0);
});

// System test
// End-to-end: Agent spawn → task execution → cost tracking → UI display
```

## **🔧 TOOLS & FRAMEWORKS**

**Required Testing Tools:**
- **Jest**: Unit testing framework
- **React Testing Library**: Component testing
- **Cypress/Playwright**: E2E testing
- **Storybook**: Component visual testing
- **Coverage tools**: NYC, Istanbul

## **📊 METRICS & REPORTING**

**Track and report:**
- Test coverage percentage
- Test execution time
- Visual regression detection
- Browser compatibility matrix
- Mobile responsiveness checklist

---

**REMEMBER: Quality is not negotiable. Testing saves time by preventing bugs, builds trust through reliability, and ensures professional delivery.**

*This applies to EVERY AGENT: Garion, Silk, Barak, Ce'Nedra, Durnik, Beldin, Polgara, Taiba, Errand, Mandorallen, Relg*