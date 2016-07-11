package com.catamania.pocajax;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.annotation.PostConstruct;
import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;
import javax.servlet.http.HttpServletRequest;

import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.content.JCRPropertyWrapper;
import org.jahia.services.content.JCRSessionFactory;
import org.jahia.services.content.JCRSessionWrapper;
import org.jahia.services.query.QueryResultWrapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * cf jahia-spring-ajax.xml - controller spring mvc
 */
@Controller
public class SearchController {
	
	/**
	 * http://localhost:8080/cms/elements?searchedText=Raccoon
	 */
    @RequestMapping(method= RequestMethod.GET,value="/elements",headers="Accept=application/json")
    public @ResponseBody List<String> getElements(HttpServletRequest request) {
    	
    	String searchedText = request.getParameter("searchedText");
    	List<String> retour = new ArrayList<String>();
    	
    	try {
			JCRSessionWrapper session = JCRSessionFactory.getInstance().getCurrentUserSession(null, Locale.ENGLISH);
			QueryManager queryManager = session.getWorkspace().getQueryManager();
			
			/*SQL2*/
			String query = "SELECT child.* FROM [catpoc:imgHolder] AS child "
								+ "INNER JOIN [catpoc:element] AS parent "
							+ "ON ISCHILDNODE(child,parent) "
							+ "WHERE parent.[name] = '" + searchedText + "'";
			
			Query q = queryManager.createQuery(query, Query.JCR_SQL2);
			QueryResultWrapper queryResult = (QueryResultWrapper) q.execute();  
			
			for(NodeIterator it = queryResult.getNodes(); it.hasNext();) {
				JCRNodeWrapper node = (JCRNodeWrapper) it.next();
				JCRPropertyWrapper p = node.getProperty("weakReferenceFileMimeImage");
				retour.add(p.getNode().getPath());
			}
			
		} catch (RepositoryException e) {
			e.printStackTrace();
		}
    	
    	return retour;
    }
}
