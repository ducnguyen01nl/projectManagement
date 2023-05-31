using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BTL_LTWNC.Data
{
    public class Project
    {
        public int PROJECT_ID { get; set; }
        public string NAME { get; set; }
        public string DESCRIPTION { get; set; }
        public DateTime? START_AT { get; set; } = null;
        public DateTime? END_AT { get; set; } = null;
        public DateTime? DELAY_DATE { get; set; } = null;
        public bool IS_ACTIVE { get; set; }
        public bool IS_SUCCESS { get; set; }
        public DateTime CREATED_AT { get; set; }
        public DateTime UPDATED_AT { get; set; }
        public bool IS_DELETED { get; set; }

        public string BACKGROUND_URL { get; set; }
    }
}