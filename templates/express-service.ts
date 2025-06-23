import { Request, Response, NextFunction } from 'express';
import { validationResult, ValidationError } from 'express-validator';
import { Logger } from '../utils/logger';

export interface ServiceResponse<T = any> {
  success: boolean;
  data?: T;
  error?: string;
  errors?: ValidationError[];
}

export abstract class BaseService {
  protected logger: Logger;

  constructor(logger: Logger) {
    this.logger = logger;
  }

  /**
   * Standard request handler wrapper with validation and error handling
   */
  protected async handleRequest<T>(
    req: Request,
    res: Response,
    next: NextFunction,
    handler: (req: Request) => Promise<T>
  ): Promise<void> {
    try {
      // Input validation
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        const response: ServiceResponse = {
          success: false,
          errors: errors.array()
        };
        res.status(400).json(response);
        return;
      }

      // Execute business logic
      const result = await handler(req);

      const response: ServiceResponse<T> = {
        success: true,
        data: result
      };

      res.json(response);
    } catch (error) {
      this.logger.error('Service error:', error);

      const response: ServiceResponse = {
        success: false,
        error: error instanceof Error ? error.message : 'Internal server error'
      };

      res.status(500).json(response);
    }
  }

  /**
   * Standard async route handler pattern
   */
  protected asyncHandler(
    fn: (req: Request, res: Response, next: NextFunction) => Promise<any>
  ) {
    return (req: Request, res: Response, next: NextFunction) => {
      Promise.resolve(fn(req, res, next)).catch(next);
    };
  }
}

// Example implementation
export class UserService extends BaseService {
  async getUsers(req: Request, res: Response, next: NextFunction) {
    return this.handleRequest(req, res, next, async (req) => {
      // Business logic here
      const users = await this.fetchUsers();
      return users;
    });
  }

  private async fetchUsers() {
    // Implementation
    return [];
  }
}
