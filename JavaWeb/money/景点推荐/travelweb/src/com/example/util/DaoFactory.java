package com.example.util;

import com.example.dao.AttractionDao;
import com.example.dao.impl.AttractionDaoImpl;

public class DaoFactory {
    private static final AttractionDao attractionDao = new AttractionDaoImpl();
    
    public static AttractionDao getAttractionDao() {
        return attractionDao;
    }
} 