package calculator;

import jakarta.servlet.ServletException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Stack;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/Calculator")
public class Calculator extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private double evaluateExpression(String expression) throws Exception {
		expression = expression.replaceAll("\\s+", "");

        Stack<Double> values = new Stack<>();  
        Stack<Character> operators = new Stack<>(); 
        
        for (int i = 0; i < expression.length(); i++) {
            char c = expression.charAt(i);
            if (Character.isDigit(c) || c == '.') {
                StringBuilder sb = new StringBuilder();
                while (i < expression.length() && (Character.isDigit(expression.charAt(i)) || expression.charAt(i) == '.')) {
                    sb.append(expression.charAt(i));
                    i++;
                }
                i--; 
                
                values.push(Double.parseDouble(sb.toString()));
            } 
            else if (c == '+' || c == '-' || c == '*' || c == '/') {
                while (!operators.isEmpty() && hasPrecedence(c, operators.peek())) {
                    values.push(applyOperation(operators.pop(), values.pop(), values.pop()));
                }
                operators.push(c);
            }
            else if (c == '(') {
                operators.push(c);
            } 
            else if (c == ')') {
                while (operators.peek() != '(') {
                    values.push(applyOperation(operators.pop(), values.pop(), values.pop()));
                }
                operators.pop();  // Pop the '(' from the stack
            }
        }

        // Process any remaining operations
        while (!operators.isEmpty()) {
            values.push(applyOperation(operators.pop(), values.pop(), values.pop()));
        }

        // The final result is at the top of the values stack
        return values.pop();
    }

    // Check operator precedence
    private boolean hasPrecedence(char op1, char op2) {
        if (op2 == '(' || op2 == ')') {
            return false;
        }
        if ((op1 == '*' || op1 == '/') && (op2 == '+' || op2 == '-')) {
            return false;
        }
        return true;
    }

    // Apply the operation to the operands
    private double applyOperation(char operator, double b, double a) {
        switch (operator) {
            case '+': return a + b;
            case '-': return a - b;
            case '*': return a * b;
            case '/': 
                if (b == 0) throw new ArithmeticException("Cannot divide by zero");
                return a / b;
        }
        return 0;
    }

    // Format the result as integer or decimal

	private String formatResult(double result) {
        if (result == (int) result) {
            return String.valueOf((int) result); 
        } else {
            return String.format("%.2f", result);  
        }
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String expression = request.getParameter("display");
        String result;

        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
		ArrayList<String> history = (ArrayList<String>) session.getAttribute("history");

        if (history == null) {
            history = new ArrayList<>();
        }

        try {
            if (expression == null || expression.trim().isEmpty()) {
                result = "Error!";
            } else {
                double evalResult = evaluateExpression(expression);

                if (Double.isInfinite(evalResult) || Double.isNaN(evalResult)) {
                    result = "Error!";
                } else {
                    result = formatResult(evalResult);
                    history.add(0, expression + " = " + result); // Add to history
                    if (history.size() > 10) { // Keep only last 5 calculations
                        history.remove(history.size() - 1);
                    }
                }
            }
        } catch (Exception e) {
            result = "Error!";
        }

        session.setAttribute("history", history);
        request.setAttribute("result", result);
        request.setAttribute("history", history);
        request.getRequestDispatcher("Caculator.jsp").forward(request, response);
	}

}
