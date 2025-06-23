from __future__ import annotations

import asyncio
import logging
from abc import ABC, abstractmethod
from dataclasses import dataclass
from typing import Any, Dict, List, Optional, TypeVar, Generic
from contextlib import asynccontextmanager
from datetime import datetime

# Type variables
T = TypeVar('T')
R = TypeVar('R')

# Response models
@dataclass
class ServiceResponse(Generic[T]):
    """Standard response format for all services"""
    success: bool
    data: Optional[T] = None
    error: Optional[str] = None
    timestamp: datetime = datetime.now()

@dataclass
class ServiceError(Exception):
    """Standard service exception"""
    message: str
    code: str = "SERVICE_ERROR"
    details: Optional[Dict[str, Any]] = None

# Base service class
class BaseService(ABC):
    """Base class for all services with common functionality"""

    def __init__(self, logger: Optional[logging.Logger] = None):
        self.logger = logger or logging.getLogger(self.__class__.__name__)

    async def execute(self, *args, **kwargs) -> ServiceResponse[T]:
        """Execute service with error handling and logging"""
        try:
            self.logger.info(f"Executing {self.__class__.__name__}")
            result = await self._execute(*args, **kwargs)

            return ServiceResponse(
                success=True,
                data=result
            )
        except ServiceError as e:
            self.logger.error(f"Service error: {e.message}", exc_info=True)
            return ServiceResponse(
                success=False,
                error=e.message
            )
        except Exception as e:
            self.logger.error(f"Unexpected error: {str(e)}", exc_info=True)
            return ServiceResponse(
                success=False,
                error="An unexpected error occurred"
            )

    @abstractmethod
    async def _execute(self, *args, **kwargs) -> T:
        """Implement service-specific logic here"""
        pass

    @asynccontextmanager
    async def transaction(self):
        """Context manager for database transactions"""
        # Begin transaction
        self.logger.debug("Beginning transaction")
        try:
            yield
            # Commit transaction
            self.logger.debug("Committing transaction")
        except Exception as e:
            # Rollback transaction
            self.logger.debug("Rolling back transaction")
            raise

# Example implementation
class ExampleService(BaseService):
    """Example service implementation"""

    def __init__(self, database_url: str, logger: Optional[logging.Logger] = None):
        super().__init__(logger)
        self.database_url = database_url

    async def _execute(self, user_id: int) -> Dict[str, Any]:
        """Get user data"""
        async with self.transaction():
            # Simulate database operation
            await asyncio.sleep(0.1)

            if user_id <= 0:
                raise ServiceError(
                    message="Invalid user ID",
                    code="INVALID_USER_ID",
                    details={"user_id": user_id}
                )

            return {
                "id": user_id,
                "name": f"User {user_id}",
                "created_at": datetime.now().isoformat()
            }

# Usage example
async def main():
    service = ExampleService(database_url="sqlite:///example.db")
    response = await service.execute(user_id=1)

    if response.success:
        print(f"Data: {response.data}")
    else:
        print(f"Error: {response.error}")

if __name__ == "__main__":
    asyncio.run(main())
