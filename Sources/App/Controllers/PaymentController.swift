//
//  PaymentController.swift
//  AppForgeServer
//
//  Created by Aliaksandr Yashchuk on 11/7/24.
//

import Vapor

struct PaymentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let payments = routes.grouped("payments")
        payments.post(use: createPayment)
        payments.post("process", use: processPayment)
    }
    
    func createPayment(req: Request) throws -> EventLoopFuture<PaymentResponse> {
        let payment = try req.content.decode(Payment.self)
        
        let response = PaymentResponse(
            amount: payment.amount,
            message: "Payment created successfully",
            receiptLink: PaymentResponse.ReceiptLink(
                href: "https://example.com/receipt",
                title: "View Receipt",
                templated: false
            )
        )
        return req.eventLoop.makeSucceededFuture(response)
    }
      
      func processPayment(req: Request) throws -> EventLoopFuture<PaymentResponse> {
          let paymentRequest = try req.content.decode(PaymentRequest.self)
          
          // Здесь добавьте логику для верификации и обработки платежного токена с использованием стороннего процессора
          // Например, передайте токен в платежный процессор, такой как Stripe или Braintree

          let response = PaymentResponse(
              amount: 10.0, // Здесь должна быть фактическая сумма транзакции
              message: "Payment processed successfully",
              receiptLink: PaymentResponse.ReceiptLink(
                  href: "https://example.com/receipt",
                  title: "View Receipt",
                  templated: false
              )
          )
          return req.eventLoop.makeSucceededFuture(response)
      }
}

struct PaymentResponse: Content {
    let amount: Double
    let message: String
    let receiptLink: ReceiptLink?
    
    struct ReceiptLink: Content {
        let href: String
        let title: String?
        let templated: Bool
    }
}

struct PaymentRequest: Content {
    let paymentToken: String
}
