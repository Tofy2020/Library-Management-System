select * from tbl_book_copies
select * from tbl_library_branch
select * from tbl_book
select * from tbl_borrower
select * from tbl_book_loans
select * from tbl_publisher
select * from tbl_book_authors
/* #1- How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"? */
select copies.book_copies_BranchID as [branch ID], branch.library_branch_BranchName as [branch Name], copies.book_copies_No_Of_Copies as [Number of Copies], book.book_Title as [Book Title]
from tbl_book_copies as copies
inner join tbl_book as book on copies.book_copies_BookID = book.book_BookID
inner join tbl_library_branch as branch on copies.book_copies_BranchID = branch.library_branch_BranchID 
where book_Title = 'The Lost Tribe' and library_branch_BranchName = 'Sharpstown';

/* #2- How many copies of the book titled "The Lost Tribe" are owned by each library branch? */
select copies.book_copies_BranchID as [branch ID], branch.library_branch_BranchName as [branch Name], copies.book_copies_No_Of_Copies as [Number of Copies], book.book_Title as [Book Title]
from tbl_book_copies as copies
inner join tbl_book as book on copies.book_copies_BookID = book.book_BookID
inner join tbl_library_branch as branch on copies.book_copies_BranchID = branch.library_branch_BranchID 
where book_Title = 'The Lost Tribe' 

/* #3- Retrieve the names of all borrowers who do not have any books checked out. */

SELECT borrower_BorrowerName FROM tbl_borrower
	WHERE NOT EXISTS
		(SELECT * FROM tbl_book_loans
		WHERE book_loans_CardNo = borrower_CardNo)

/* #4- For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today,
retrieve the book title, the borrower's name,and the borrower's address.  */
select book.book_Title, borrower.borrower_BorrowerName, borrower.borrower_BorrowerAddress
from tbl_book_loans as loans
inner join tbl_book as book on loans.book_loans_BookID = book.book_BookID
inner join tbl_borrower as borrower on loans.book_loans_CardNo = borrower.borrower_CardNo
inner join tbl_library_branch as branch on loans.book_loans_BranchID= branch.library_branch_BranchID
where loans.book_loans_DueDate = null and  branch.library_branch_BranchName = 'Sharpstown' 
 
 /* #5- For each library branch, retrieve the branch name and the total number of books loaned out from that branch.  */
 select branch.library_branch_BranchName as branch_name, count(book_loans_BranchID) as Total_Book_loans from tbl_book_loans as loans
 inner join tbl_library_branch as branch on loans.book_loans_BranchID = branch.library_branch_BranchID
 group by branch.library_branch_BranchName 

 /* #6- Retrieve the names, addresses, and number of books checked out
 for all borrowers who have more than five books checked out. */

select borrower.borrower_BorrowerName, borrower.borrower_BorrowerAddress, COUNT(borrower.borrower_BorrowerName)
from tbl_book_loans as loans
INNER JOIN tbl_borrower AS Borrower ON Loans.book_loans_CardNo = Borrower.borrower_CardNo
group by borrower.borrower_BorrowerName, borrower.borrower_BorrowerAddress
having count(borrower.borrower_BorrowerName) > 5


/* #7- For each book authored by "Stephen King",
retrieve the title and the number of copies owned by the library branch whose name is "Central".*/

select  branch.library_branch_BranchName,
book.book_Title,
copies.book_copies_No_Of_Copies
from tbl_book_copies as copies
join tbl_book_authors as authors on authors.book_authors_AuthorID = copies.book_copies_BookID
join tbl_library_branch as branch on branch.library_branch_BranchID = copies.book_copies_BranchID
join tbl_book as book on copies.book_copies_BookID = book.book_BookID
where authors.book_authors_AuthorName = 'Stephen King'
and branch.library_branch_BranchName = 'central'





 
 

 