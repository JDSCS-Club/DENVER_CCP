/*********************************************************************
          File:        queue.h

       Version:        1.7

     Reference:        None

       Purpose:        To handle queue operations. A dynamic array
                       is used for circular implementation of queue.
                       The size of a queue item and the queue capacity
                       are chosen when the queue is created. It is
                       up to the user of the queue to interpret
                       the contents of the queue item. 

          Note:        None

         To Do:        None
*********************************************************************/
#ifndef QUEUE_H
#define QUEUE_H

/*------------------------------------------------------------------------------ 
Section: Includes
------------------------------------------------------------------------------*/ 
#include <eia709_1.h>

/*-------------------------------------------------------------------
Section: Constant Definitions
-------------------------------------------------------------------*/
/* None */

/*-------------------------------------------------------------------
Section: Type Definitions
-------------------------------------------------------------------*/
typedef struct 
{
   uint16 queueCnt;   /* Max number of items in queue. i.e capacity */
   uint16 queueSize;  /* Number of items currently in queue         */
   uint16 itemSize;   /* Number of bytes for each item in queue     */
   Byte *head;        /* Pointer to the head item of the queue      */
   Byte *tail;        /* Pointer to the tail item of the queue      */
   Byte *data;        /* Array of items -- Allocated during Init    */
} Queue;

/*-------------------------------------------------------------------
Section: Globals 
-------------------------------------------------------------------*/
/* None */

/*-------------------------------------------------------------------
Section: Function Prototypes
-------------------------------------------------------------------*/
/* QueueSize returns the current size of the queue. */
uint16    QueueSize(Queue *qInp);

/* QueueCnt returns the capacity (i.e max items) of the queue. */
uint16    QueueCnt(Queue *qInp);

/* QueueItemSize returns the size of each item in the queue. */
uint16    QueueItemSize(Queue *qInp);

/* QueueFull returns TRUE if the queue is full and FALSE otherwise. */
Boolean   QueueFull(Queue *qInp);

/* QueueEmpty returns TRUE if the queue is empty and FALSE else. */
Boolean   QueueEmpty(Queue *qInp);

/* DeQueue removes an item (i.e advances head) from the queue. */
void      DeQueue(Queue *qInOut);

/* Enqueue adds an item (i.e advances tail) to queue. */
void      EnQueue(Queue *qInOut);

/* QueueHead returns the pointer to the head of the queue so that
   client can examine the queue's first item without actually 
   removing it. If needed it can be removed with DeQueue. */
void     *QueueHead(Queue *qInp);

/* QueueTail returns the pointer to the tail of the queue (i.e free
   space) so that a new item can be formed directly in the queue
   before calling EnQueue. It is important to make sure that the
   Queue is not Full before filling an item. */
void     *QueueTail(Queue *qInp);

/* QueueInit is used to initialize a queue. Client specifies the
   size of each item in queue and the count (capacity) of queue. */
Status    QueueInit(Queue *qOut, uint16 itemSize, uint16 qCnt);

#endif
/*************************End of queue.h***************************/
