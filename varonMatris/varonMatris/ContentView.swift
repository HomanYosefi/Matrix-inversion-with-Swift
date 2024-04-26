//
//  ContentView.swift
//  varonMatris
//
//  Created by homan on 4/13/24.
//


		
import SwiftUI

struct ContentView: View {
    @State private var matrixValues: [[Double]] = Array(repeating: Array(repeating: 0.0, count: 3), count: 3)
    @State private var invertedMatrix: [[Double]] = Array(repeating: Array(repeating: 0.0, count: 3), count: 3)
    
    var body: some View {
        VStack {
            Text("Enter Matrix Values:")
                .font(.title)
                .padding()
            
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { col in
                        TextField("", value: self.$matrixValues[row][col], formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 50)
                    }
                }
            }
            
            Button(action: {
                self.invertMatrix()
            }) {
                Text("Invert Matrix")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Text("Inverted Matrix:")
                .font(.title)
                .padding()
            
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { col in
                        Text(String(format: "%.3f", self.invertedMatrix[row][col]))
                            .frame(width: 50)
                    }
                }
            }
        }
        .padding()
    }
    
    func invertMatrix() {
        // Convert matrixValues to Double
        var matrix = [[Double]](repeating: [Double](repeating: 0, count: 3), count: 3)
        for i in 0..<3 {
            for j in 0..<3 {
                matrix[i][j] = Double(matrixValues[i][j])
            }
        }
        
        // Calculate determinant
        let det = matrix[0][0] * (matrix[1][1] * matrix[2][2] - matrix[1][2] * matrix[2][1]) +
                   matrix[0][1] * (matrix[1][2] * matrix[2][0] - matrix[1][0] * matrix[2][2]) +
                   matrix[0][2] * (matrix[1][0] * matrix[2][1] - matrix[1][1] * matrix[2][0])
        
        if det != 0 {
            // Calculate adjoint matrix
            var adjointMatrix = [[Double]](repeating: [Double](repeating: 0, count: 3), count: 3)
            adjointMatrix[0][0] = matrix[1][1] * matrix[2][2] - matrix[1][2] * matrix[2][1]
            adjointMatrix[0][1] = matrix[0][2] * matrix[2][1] - matrix[0][1] * matrix[2][2]
            adjointMatrix[0][2] = matrix[0][1] * matrix[1][2] - matrix[0][2] * matrix[1][1]
            adjointMatrix[1][0] = matrix[1][2] * matrix[2][0] - matrix[1][0] * matrix[2][2]
            adjointMatrix[1][1] = matrix[0][0] * matrix[2][2] - matrix[0][2] * matrix[2][0]
            adjointMatrix[1][2] = matrix[0][2] * matrix[1][0] - matrix[0][0] * matrix[1][2]
            adjointMatrix[2][0] = matrix[1][0] * matrix[2][1] - matrix[1][1] * matrix[2][0]
            adjointMatrix[2][1] = matrix[0][1] * matrix[2][0] - matrix[0][0] * matrix[2][1]
            adjointMatrix[2][2] = matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0]
            
            // Calculate inverted matrix
            for i in 0..<3 {
                for j in 0..<3 {
                    invertedMatrix[i][j] = adjointMatrix[i][j] / det
                }
            }
        } else {
            // Handle case where determinant is 0
            // You may display an error message or handle it as per your requirement
            print("Determinant is 0. Matrix cannot be inverted.")
        }
    }    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
