package com.nekuata.manage.utils;

import java.util.List;

/**
 * Created by nekuata on 2017/7/19.
 */
public class DataTables {
    private Long recordsTotal;
    private Long recordsFiltered;
    private List<?> data;

    public DataTables() {
    }

    public DataTables(Long recordsTotal, Long recordsFiltered, List<?> data) {
        this.recordsTotal = recordsTotal;
        this.recordsFiltered = recordsFiltered;
        this.data = data;
    }

    public Long getRecordsTotal() {
        return recordsTotal;
    }

    public void setRecordsTotal(Long recordsTotal) {
        this.recordsTotal = recordsTotal;
    }

    public Long getRecordsFiltered() {
        return recordsFiltered;
    }

    public void setRecordsFiltered(Long recordsFiltered) {
        this.recordsFiltered = recordsFiltered;
    }

    public List<?> getData() {
        return data;
    }

    public void setData(List<?> data) {
        this.data = data;
    }
}
