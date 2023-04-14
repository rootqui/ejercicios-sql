USE Pubs
-- Elimina los autores que no han escrito libros

DELETE authors
WHERE au_id NOT IN (SELECT DISTINCT Au_Id FROM TitleAuthor)